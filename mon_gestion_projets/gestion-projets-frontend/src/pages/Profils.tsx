import React, { useState, useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Shield, Plus, Search, Edit2, Trash2, X } from 'lucide-react';
import toast from 'react-hot-toast';
import { profilService } from '../services/profilService';


const emptyForm = { code: '', libelle: '', description: '' };

const Profils: React.FC = () => {
  // user is unused here

  const [profils, setProfils] = useState<any[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [isDeleteOpen, setIsDeleteOpen] = useState(false);
  const [selected, setSelected] = useState<any>(null);
  const [form, setForm] = useState(emptyForm);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const fetchProfils = async () => {
    setIsLoading(true);
    try {
      const res = await profilService.getAll();
      setProfils(res.data || []);
    } catch {
      toast.error('Erreur lors du chargement des profils');
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => { fetchProfils(); }, []);

  const handleCreate = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);
    try {
      await profilService.create({ code: form.code.toUpperCase(), libelle: form.libelle, description: form.description || undefined });
      toast.success('Profil créé avec succès !');
      setIsCreateOpen(false);
      setForm(emptyForm);
      fetchProfils();
    } catch (err: any) {
      toast.error(err.response?.data?.message || 'Erreur lors de la création');
    } finally {
      setIsSubmitting(false);
    }
  };

  const openEdit = (profil: any) => {
    setSelected(profil);
    setForm({ code: profil.code || '', libelle: profil.libelle || '', description: profil.description || '' });
    setIsEditOpen(true);
  };

  const handleEdit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!selected) return;
    setIsSubmitting(true);
    try {
      await profilService.update(selected.id, { code: form.code.toUpperCase(), libelle: form.libelle, description: form.description || undefined });
      toast.success('Profil modifié avec succès !');
      setIsEditOpen(false);
      setSelected(null);
      fetchProfils();
    } catch (err: any) {
      toast.error(err.response?.data?.message || 'Erreur de modification');
    } finally {
      setIsSubmitting(false);
    }
  };

  const openDelete = (profil: any) => { setSelected(profil); setIsDeleteOpen(true); };

  const handleDelete = async () => {
    if (!selected) return;
    setIsSubmitting(true);
    try {
      await profilService.delete(selected.id);
      toast.success('Profil supprimé !');
      setIsDeleteOpen(false);
      setSelected(null);
      fetchProfils();
    } catch (err: any) {
      toast.error(err.response?.data?.message || 'Erreur de suppression');
    } finally {
      setIsSubmitting(false);
    }
  };

  const filtered = profils.filter(p =>
    (p.libelle || '').toLowerCase().includes(searchTerm.toLowerCase()) ||
    (p.code || '').toLowerCase().includes(searchTerm.toLowerCase())
  );

  const renderForm = (onSubmit: (e: React.FormEvent) => Promise<void>, title: string) => (
    <div className="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4">
      <motion.div initial={{ opacity: 0, scale: 0.95 }} animate={{ opacity: 1, scale: 1 }}
        className="bg-white border border-[#d5d9d9] rounded-lg p-6 w-full max-w-md relative shadow-xl">
        <button onClick={() => { setIsCreateOpen(false); setIsEditOpen(false); }} className="absolute top-4 right-4 text-[#565959] hover:text-[#0f1111]"><X size={20} /></button>
        <h2 className="text-xl font-bold mb-6 text-[#0f1111]">{title}</h2>

        <form onSubmit={onSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-bold mb-1 text-[#0f1111]">Code *</label>
            <input
              type="text" required
              className="w-full border border-[#a6a6a6] rounded-[3px] p-2 focus:border-[#e77600] focus:shadow-[0_0_3px_2px_rgba(228,121,17,.5)] outline-none transition-all uppercase font-mono"
              placeholder="ex: ADMIN"
              value={form.code}
              onChange={e => setForm({ ...form, code: e.target.value.toUpperCase() })}
            />
          </div>
          <div>
            <label className="block text-sm font-bold mb-1 text-[#0f1111]">Libellé *</label>
            <input
              type="text" required
              className="w-full border border-[#a6a6a6] rounded-[3px] p-2 focus:border-[#e77600] focus:shadow-[0_0_3px_2px_rgba(228,121,17,.5)] outline-none transition-all"
              placeholder="ex: Administrateur"
              value={form.libelle}
              onChange={e => setForm({ ...form, libelle: e.target.value })}
            />
          </div>
          <div>
            <label className="block text-sm font-bold mb-1 text-[#0f1111]">Description</label>
            <textarea
              className="w-full border border-[#a6a6a6] rounded-[3px] p-2 focus:border-[#e77600] focus:shadow-[0_0_3px_2px_rgba(228,121,17,.5)] outline-none transition-all min-h-[80px]"
              placeholder="Rôle et permissions..."
              value={form.description}
              onChange={e => setForm({ ...form, description: e.target.value })}
            />
          </div>
          <div className="pt-4 flex justify-end gap-3 border-t border-[#e7e7e7]">
            <button type="button" onClick={() => { setIsCreateOpen(false); setIsEditOpen(false); }} className="px-4 py-2 text-sm text-[#0f1111] hover:underline">Annuler</button>
            <button type="submit" disabled={isSubmitting} className="bg-[#ffd814] border border-[#a88734] hover:bg-[#f7dfa1] px-6 py-1.5 rounded-[3px] text-sm font-medium shadow-sm">
              {isSubmitting ? 'Enregistrement...' : 'Enregistrer'}
            </button>
          </div>
        </form>
      </motion.div>
    </div>
  );
const descriptions = {
  'ADMINISTRATEUR': 'Accès complet au système. Gère les comptes utilisateurs, les profils et toutes les ressources de l\'application.',
  'DIRECTEUR':      'Supervise l\'ensemble des projets et des équipes. Accès aux tableaux de bord, reporting et pilotage global.',
  'SECRETAIRE':     'Gère les organismes clients et les informations administratives des projets. Création et mise à jour des dossiers projets.',
  'CHEF_PROJET':    'Responsable opérationnel des projets. Gère les phases, affecte les employés, suit les livrables et documents.',
  'COMPTABLE':      'Gère la facturation et le suivi financier. Consulte les phases terminées, facturées et payées.',
  'TECHNICIEN':     'Intervient sur les phases des projets en tant que membre de l\'équipe technique.',
  'INGENIEUR':      'Expert technique affecté aux phases de développement et d\'études des projets.',
  'EMPLOYE':        'Utilisateur standard avec accès limité aux informations le concernant directement.',
};


  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center bg-white p-4 border border-[#d5d9d9] rounded-lg shadow-sm">
        <div>
          <h1 className="text-2xl font-bold text-[#0f1111] flex items-center gap-2">
            <Shield size={24} className="text-[#232f3e]" /> Gestion des Profils
          </h1>
          <p className="text-[#565959] text-sm mt-1">Gérez les rôles et permissions d'accès au système.</p>
        </div>
        <button onClick={() => { setForm(emptyForm); setIsCreateOpen(true); }} className="bg-[#ffd814] border border-[#a88734] hover:bg-[#f7dfa1] px-4 py-2 rounded-lg text-sm font-medium shadow-sm flex items-center gap-2">
          <Plus size={18} /> Nouveau Profil
        </button>
      </div>

      {/* Barre de recherche */}
      <div className="relative max-w-md">
        <span className="absolute inset-y-0 left-0 pl-3 flex items-center text-[#565959]">
          <Search size={18} />
        </span>
        <input
          type="text"
          placeholder="Rechercher un profil..."
          className="w-full pl-10 pr-4 py-2 border border-[#a6a6a6] rounded-md focus:border-[#e77600] focus:shadow-[0_0_3px_2px_rgba(228,121,17,.5)] outline-none"
          value={searchTerm}
          onChange={e => setSearchTerm(e.target.value)}
        />
      </div>

      {/* Liste des Profils sous forme de cartes  */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {isLoading ? (
          <div className="col-span-full py-20 text-center text-[#565959]">Chargement...</div>
        ) : filtered.length === 0 ? (
          <div className="col-span-full py-20 text-center text-[#565959] bg-white border border-dashed border-[#d5d9d9] rounded-lg">Aucun profil trouvé.</div>
        ) : (
          filtered.map((profil, idx) => (
            <motion.div
              key={profil.id}
              initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: idx * 0.1 }}
              className="bg-white border border-[#d5d9d9] rounded-lg overflow-hidden hover:border-[#adb1b1] shadow-sm group"
            >
              <div className="p-5">
                <div className="flex justify-between items-start mb-4">
                  <div className="p-3 bg-[#f0f2f2] rounded-full text-[#232f3e] group-hover:bg-[#ff9900] group-hover:text-white transition-colors">
                    <Shield size={28} />
                  </div>
                  <div className="flex gap-1">
                    <button onClick={() => openEdit(profil)} className="p-2 text-[#565959] hover:text-[#007185] hover:bg-[#f0f2f2] rounded-full transition-colors"><Edit2 size={16} /></button>
                    <button onClick={() => openDelete(profil)} className="p-2 text-[#b12704] hover:bg-[#fdf0f0] rounded-full transition-colors"><Trash2 size={16} /></button>
                  </div>
                </div>

                <h3 className="text-lg font-bold text-[#0f1111]">{profil.libelle}</h3>
                <div className="mt-1 flex items-center gap-2">
                   <span className="px-2 py-0.5 bg-[#f0f2f2] text-[#565959] text-[10px] font-bold rounded border border-[#d5d9d9] uppercase tracking-wider">
                    {profil.code}
                  </span>
                </div>
                <p className="mt-3 text-sm text-[#565959] line-clamp-2 min-h-[40px]">
                  {descriptions[profil.code as keyof typeof descriptions] || 'Aucune description fournie pour ce rôle.'}
                </p>
              </div>
            </motion.div>
          ))
        )}
      </div>

      {/* MODALS */}
      <AnimatePresence>
        {isCreateOpen && renderForm(handleCreate, "Créer un nouveau profil")}
        {isEditOpen && renderForm(handleEdit, "Modifier le profil")}

        {isDeleteOpen && selected && (
          <div className="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-4">
            <motion.div initial={{ opacity: 0, scale: 0.95 }} animate={{ opacity: 1, scale: 1 }}
              className="bg-white border border-[#d5d9d9] rounded-lg p-6 w-full max-w-sm relative shadow-xl text-center">
              <div className="w-16 h-16 bg-[#fdf0f0] rounded-full flex items-center justify-center mx-auto mb-4">
                <Trash2 size={32} className="text-[#b12704]" />
              </div>
              <h2 className="text-xl font-bold text-[#0f1111] mb-2">Confirmer la suppression</h2>
              <p className="text-[#565959] text-sm mb-6">Êtes-vous sûr de vouloir supprimer le profil <span className="font-bold text-[#0f1111]">"{selected.libelle}"</span> ? Cette action est irréversible.</p>
              <div className="flex gap-3">
                <button onClick={() => setIsDeleteOpen(false)} className="flex-1 px-4 py-2 border border-[#adb1b1] rounded-lg text-sm hover:bg-[#f7fafa]">Annuler</button>
                <button onClick={handleDelete} className="flex-1 px-4 py-2 bg-[#b12704] hover:bg-[#a22000] text-white rounded-lg text-sm font-medium">Supprimer</button>
              </div>
            </motion.div>
          </div>
        )}
      </AnimatePresence>
    </div>
  );
};

export default Profils;