
import { Link, useLocation } from 'react-router-dom';
import {
  LayoutDashboard, Building2, Users, FolderKanban,
  Layers, UserCheck, FileCheck2, FileStack, FileText, BarChart3, ShieldCheck
} from 'lucide-react';
import { useAuth } from '../context/AuthContext';

const Sidebar = () => {
  const { user } = useAuth();
  const location = useLocation();
  const userRole = user?.profil?.code?.toUpperCase();

  const menuGroups = [
    {
      title: "Principal",
      roles: ['ADMINISTRATEUR', 'ADMIN', 'DIRECTEUR', 'CHEF_PROJET', 'COMPTABLE', 'TECHNICIEN', 'INGENIEUR', 'SECRETAIRE'],
      items: [
        { path: '/', icon: <LayoutDashboard size={20} />, label: 'Tableau de bord', roles: ['ADMINISTRATEUR', 'ADMIN', 'DIRECTEUR', 'CHEF_PROJET', 'COMPTABLE', 'TECHNICIEN', 'INGENIEUR', 'SECRETAIRE'] }
      ]
    },
    {
      title: "Gestion Métier",
      roles: ['ADMINISTRATEUR', 'ADMIN', 'CHEF_PROJET', 'SECRETAIRE', 'DIRECTEUR'],
      items: [
        { path: '/organismes', icon: <Building2 size={20} />, label: 'Organismes', roles: ['ADMINISTRATEUR', 'ADMIN', 'CHEF_PROJET', 'SECRETAIRE', 'DIRECTEUR'] },
        { path: '/projets', icon: <FolderKanban size={20} />, label: 'Projets', roles: ['ADMINISTRATEUR', 'ADMIN', 'CHEF_PROJET', 'SECRETAIRE', 'DIRECTEUR'] },
      ]
    },
    {
      title: "Administration",
      roles: ['ADMINISTRATEUR', 'ADMIN'],
      items: [
        { path: '/employes', icon: <Users size={20} />, label: 'Employés', roles: ['ADMINISTRATEUR', 'ADMIN'] },
        { path: '/profils', icon: <ShieldCheck size={20} />, label: 'Profils', roles: ['ADMINISTRATEUR', 'ADMIN'] },
      ]
    },
    {
      title: "Exécution",
      roles: ['ADMINISTRATEUR', 'ADMIN', 'CHEF_PROJET', 'TECHNICIEN', 'INGENIEUR', 'DIRECTEUR', 'COMPTABLE'],
      items: [
        { path: '/phases', icon: <Layers size={20} />, label: 'Phases', roles: ['ADMINISTRATEUR', 'ADMIN', 'CHEF_PROJET', 'DIRECTEUR', 'TECHNICIEN', 'INGENIEUR', 'COMPTABLE'] },
        { path: '/affectations', icon: <UserCheck size={20} />, label: 'Affectations', roles: ['ADMINISTRATEUR', 'ADMIN', 'CHEF_PROJET', 'DIRECTEUR', 'TECHNICIEN', 'INGENIEUR'] },
        { path: '/livrables', icon: <FileCheck2 size={20} />, label: 'Livrables', roles: ['ADMINISTRATEUR', 'ADMIN', 'CHEF_PROJET', 'DIRECTEUR', 'TECHNICIEN', 'INGENIEUR'] },
        { path: '/documents', icon: <FileStack size={20} />, label: 'Documents', roles: ['ADMINISTRATEUR', 'ADMIN', 'CHEF_PROJET', 'DIRECTEUR', 'TECHNICIEN', 'INGENIEUR'] },
      ]
    },
    {
      title: "Finance & Reporting",
      roles: ['ADMINISTRATEUR', 'ADMIN', 'COMPTABLE', 'DIRECTEUR'],
      items: [
        { path: '/factures', icon: <FileText size={20} />, label: 'Factures', roles: ['ADMINISTRATEUR', 'ADMIN', 'COMPTABLE', 'DIRECTEUR'] },
        { path: '/reporting', icon: <BarChart3 size={20} />, label: 'Reporting', roles: ['ADMINISTRATEUR', 'ADMIN', 'COMPTABLE', 'DIRECTEUR'] },
      ]
    }
  ];

  return (
    <aside className="w-64 bg-[#232f3e] text-white flex flex-col h-screen sticky top-0">
      <div className="p-6 border-b border-white/10">
        <h1 className="text-xl font-bold text-[#ff9900]">ProjetFlow</h1>
      </div>

      <nav className="flex-1 overflow-y-auto p-4 space-y-8">
        {menuGroups.map((group, idx) => (
          group.roles.includes(userRole || '') && (
            <div key={idx}>
              <p className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-4 px-2">{group.title}</p>
              <div className="space-y-1">
                {group.items.map((item) => (
                  item.roles?.includes(userRole || '') && (
                  <Link
                    key={item.path}
                    to={item.path}
                    className={`flex items-center gap-3 px-3 py-2 rounded-md transition-colors ${
                      location.pathname === item.path ? 'bg-[#37475a] text-[#ff9900]' : 'hover:bg-[#37475a] text-gray-300'
                    }`}
                  >
                    {item.icon}
                    <span className="text-sm font-medium">{item.label}</span>
                  </Link>
                  )
                ))}
              </div>
            </div>
          )
        ))}
      </nav>
    </aside>
  );
};

export default Sidebar;