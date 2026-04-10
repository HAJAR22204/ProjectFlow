import React, { useEffect, useState } from 'react';
import { motion } from 'framer-motion';
import { FolderKanban, Activity, TrendingUp, DollarSign, Layers, FileCheck2, UserCheck } from 'lucide-react';
import { 
  AreaChart, Area, XAxis, YAxis, CartesianGrid, Tooltip as RechartsTooltip, ResponsiveContainer,
  PieChart, Pie, Cell
} from 'recharts';
import api from '../utils/axiosConfig';
import { useAuth } from '../context/AuthContext';

const Dashboard: React.FC = () => {
  const [data, setData] = useState<any>(null);
  const [employeeData, setEmployeeData] = useState<any>(null);
  const [isLoading, setIsLoading] = useState(true);
  const { hasRole, user } = useAuth();
  const isAdmin = hasRole(['ADMINISTRATEUR', 'ADMIN', 'DIRECTEUR', 'COMPTABLE', 'CHEF_PROJET']);

  useEffect(() => {
    const fetchDashboard = async () => {
      try {
        if (isAdmin) {
          const response = await api.get('/reporting/tableau-de-bord');
          setData(response.data);
        } else {
          const [, projetsRes] = await Promise.allSettled([
            api.get('/projets'),
            api.get('/projets'),
          ]);
          let totalPhases = 0, phasesTerminees = 0, totalLivrables = 0, livrablesValides = 0;
          if (projetsRes.status === 'fulfilled') {
            for (const p of projetsRes.value.data || []) {
              try {
                const phRes = await api.get(`/projets/${p.id}/phases`);
                for (const ph of phRes.data || []) {
                  totalPhases++;
                  if (ph.etatRealisation) phasesTerminees++;
                  try {
                    const lvRes = await api.get(`/phases/${ph.id}/livrables`);
                    totalLivrables += (lvRes.data || []).length;
                    livrablesValides += (lvRes.data || []).filter((l: any) => l.valide).length;
                  } catch {}
                }
              } catch {}
            }
          }
          setEmployeeData({ totalPhases, phasesTerminees, totalLivrables, livrablesValides });
        }
      } catch (error) {
        console.error('Failed to fetch dashboard data', error);
      } finally {
        setIsLoading(false);
      }
    };
    fetchDashboard();
  }, [isAdmin]);

  const mockLineData = [
    { name: 'En cours', projets: data?.projetsEnCours || 0 },
    { name: 'Clôturés', projets: data?.projetsClotures || 0 },
    { name: 'Total', projets: data?.totalProjets || 0 }
  ];

  // Couleurs Amazon : Orange et Navy pour le PieChart
  const mockPieData = [
    { name: 'En cours', value: data?.projetsEnCours || 0, color: '#ff9900' },
    { name: 'Clôturés', value: data?.projetsClotures || 0, color: '#232f3e' },
  ];

  const StatCard = ({ title, value, icon, delay }: any) => (
    <motion.div
      initial={{ opacity: 0, y: 15 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ delay }}
      className="bg-white border border-[#d5d9d9] p-6 rounded-lg shadow-sm group hover:border-[#adb1b1] transition-all"
    >
      <div className="flex justify-between items-start">
        <div>
          <p className="text-[#565959] text-xs uppercase tracking-wider font-bold mb-1">{title}</p>
          <h3 className="text-3xl font-bold text-[#0f1111]">{value}</h3>
        </div>
        <div className="p-2 rounded-md bg-[#f0f2f2] text-[#232f3e] group-hover:bg-[#ff9900] group-hover:text-white transition-colors">
          {icon}
        </div>
      </div>
    </motion.div>
  );

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64 text-[#565959]">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-[#ff9900] mr-3"></div>
        Chargement des données Amazon...
      </div>
    );
  }

  // -----------------------------------------------
  // EMPLOYEE DASHBOARD (LIGHT THEME)
  // -----------------------------------------------
  if (!isAdmin) {
    const ed = employeeData || {};
    const completionRate = ed.totalPhases > 0 ? Math.round((ed.phasesTerminees / ed.totalPhases) * 100) : 0;
    const validationRate = ed.totalLivrables > 0 ? Math.round((ed.livrablesValides / ed.totalLivrables) * 100) : 0;

    return (
      <div className="space-y-6">
        <div>
          <h1 className="text-2xl font-bold text-[#0f1111]">Votre console de travail</h1>
          <p className="text-[#565959] mt-1">
            Bonjour, <span className="font-bold text-[#0f1111]">{user?.prenom || user?.login}</span> — Voici l'état de vos tâches.
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6">
          <StatCard title="Phases assignées" value={ed.totalPhases} icon={<Layers size={20} />} delay={0.1} />
          <StatCard title="Phases terminées" value={ed.phasesTerminees} icon={<TrendingUp size={20} />} delay={0.2} />
          <StatCard title="Livrables soumis" value={ed.totalLivrables} icon={<FileCheck2 size={20} />} delay={0.3} />
          <StatCard title="Livrables validés" value={ed.livrablesValides} icon={<Activity size={20} />} delay={0.4} />
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div className="bg-white border border-[#d5d9d9] p-6 rounded-lg">
            <h3 className="text-sm font-bold text-[#0f1111] mb-4">AVANCEMENT DES PHASES</h3>
            <div className="flex items-center gap-4">
              <span className="text-4xl font-bold text-[#ff9900]">{completionRate}%</span>
              <div className="flex-1">
                <div className="h-4 bg-[#f0f2f2] rounded-full overflow-hidden border border-[#d5d9d9]">
                  <motion.div initial={{ width: 0 }} animate={{ width: `${completionRate}%` }} className="h-full bg-[#ff9900]" />
                </div>
                <p className="text-xs text-[#565959] mt-2 font-medium">{ed.phasesTerminees} sur {ed.totalPhases} terminées</p>
              </div>
            </div>
          </div>

          <div className="bg-white border border-[#d5d9d9] p-6 rounded-lg">
            <h3 className="text-sm font-bold text-[#0f1111] mb-4">VALIDATION LIVRABLES</h3>
            <div className="flex items-center gap-4">
              <span className="text-4xl font-bold text-[#007185]">{validationRate}%</span>
              <div className="flex-1">
                <div className="h-4 bg-[#f0f2f2] rounded-full overflow-hidden border border-[#d5d9d9]">
                  <motion.div initial={{ width: 0 }} animate={{ width: `${validationRate}%` }} className="h-full bg-[#007185]" />
                </div>
                <p className="text-xs text-[#565959] mt-2 font-medium">{ed.livrablesValides} validés</p>
              </div>
            </div>
          </div>
        </div>

        <div className="bg-[#f3f3f3] p-5 rounded-lg border border-[#d5d9d9]">
          <p className="text-xs font-bold text-[#565959] uppercase mb-3">Accès prioritaires</p>
          <div className="flex flex-wrap gap-3">
            {[
              { label: 'Mes Phases', path: '/phases', icon: <Layers size={14} /> },
              { label: 'Livrables', path: '/livrables', icon: <FileCheck2 size={14} /> },
              { label: 'Affectations', path: '/affectations', icon: <UserCheck size={14} /> }
            ].map(link => (
              <a key={link.path} href={link.path} className="flex items-center gap-2 px-4 py-2 bg-white border border-[#d5d9d9] rounded shadow-sm text-sm text-[#007185] hover:text-[#c45500] hover:border-[#e77600] transition-all">
                {link.icon}{link.label}
              </a>
            ))}
          </div>
        </div>
      </div>
    );
  }

  // -----------------------------------------------
  // ADMIN DASHBOARD (AMAZON LIGHT THEME)
  // -----------------------------------------------
  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-2xl font-bold text-[#0f1111]">Tableau de bord administrateur</h1>
          <p className="text-[#565959] mt-1">Statistiques globales du système ProjetFlow.</p>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6">
        <StatCard title="Projets Actifs" value={data?.projetsEnCours} icon={<Activity size={20} />} delay={0.1} />
        <StatCard title="Projets Clôturés" value={data?.projetsClotures} icon={<FolderKanban size={20} />} delay={0.2} />
        <StatCard title="Phases Terminées" value={data?.phasesTerminees} icon={<TrendingUp size={20} />} delay={0.3} />
        <StatCard title="Montant Facturé" value={`${((data?.montantTotalFacture || 0) / 1000).toFixed(1)}k MAD`} icon={<DollarSign size={20} />} delay={0.4} />
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Main Amazon Chart */}
        <div className="bg-white border border-[#d5d9d9] p-6 lg:col-span-2 rounded-lg shadow-sm">
          <h3 className="text-sm font-bold text-[#0f1111] mb-6 uppercase">Activité des projets</h3>
          <div className="h-72">
            <ResponsiveContainer width="100%" height="100%">
              <AreaChart data={mockLineData}>
                <defs>
                  <linearGradient id="colorProjets" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="5%" stopColor="#ff9900" stopOpacity={0.1}/>
                    <stop offset="95%" stopColor="#ff9900" stopOpacity={0}/>
                  </linearGradient>
                </defs>
                <CartesianGrid strokeDasharray="3 3" stroke="#e7e7e7" vertical={false} />
                <XAxis dataKey="name" stroke="#565959" tick={{fill: '#565959', fontSize: 12}} axisLine={false} />
                <YAxis stroke="#565959" tick={{fill: '#565959', fontSize: 12}} axisLine={false} tickLine={false} />
                <RechartsTooltip
                  contentStyle={{ backgroundColor: '#fff', border: '1px solid #d5d9d9', borderRadius: '4px', boxShadow: '0 2px 4px rgba(0,0,0,0.1)' }}
                />
                <Area type="monotone" dataKey="projets" stroke="#ff9900" strokeWidth={2} fillOpacity={1} fill="url(#colorProjets)" />
              </AreaChart>
            </ResponsiveContainer>
          </div>
        </div>

        {/* Pie Chart */}
        <div className="bg-white border border-[#d5d9d9] p-6 rounded-lg shadow-sm">
          <h3 className="text-sm font-bold text-[#0f1111] mb-6 uppercase">Répartition des statuts</h3>
          <div className="h-72 flex items-center justify-center relative">
            <ResponsiveContainer width="100%" height="100%">
              <PieChart>
                <Pie
                  data={mockPieData}
                  cx="50%"
                  cy="50%"
                  innerRadius={70}
                  outerRadius={90}
                  paddingAngle={5}
                  dataKey="value"
                  stroke="none"
                >
                  {mockPieData.map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={entry.color} />
                  ))}
                </Pie>
                <RechartsTooltip />
              </PieChart>
            </ResponsiveContainer>
            <div className="absolute inset-0 flex flex-col items-center justify-center pointer-events-none">
              <span className="text-3xl font-bold text-[#0f1111]">{data?.totalProjets || 0}</span>
              <span className="text-[10px] text-[#565959] uppercase font-bold">Total Projets</span>
            </div>
          </div>
          <div className="mt-4 space-y-2">
            <div className="flex items-center justify-between text-xs">
              <span className="flex items-center gap-2"><div className="w-3 h-3 rounded-full bg-[#ff9900]" /> En cours</span>
              <span className="font-bold">{data?.projetsEnCours || 0}</span>
            </div>
            <div className="flex items-center justify-between text-xs">
              <span className="flex items-center gap-2"><div className="w-3 h-3 rounded-full bg-[#232f3e]" /> Clôturés</span>
              <span className="font-bold">{data?.projetsClotures || 0}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;