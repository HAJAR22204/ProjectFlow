import React, { useState } from 'react';
import { LogOut, Bell, ChevronDown } from 'lucide-react';
import { useAuth } from '../context/AuthContext';
import { motion, AnimatePresence } from 'framer-motion';

const Topbar: React.FC = () => {
  const { user, logout } = useAuth();
  const [showNotifications, setShowNotifications] = useState(false);
  const [showUser, setShowUser] = useState(false);

  return (
    <header className="h-16 flex items-center justify-between px-6 z-[100] sticky top-0"
      style={{
        background: 'rgba(10, 15, 30, 0.7)',
        backdropFilter: 'blur(16px)',
        borderBottom: '1px solid rgba(255,255,255,0.05)'
      }}>
      <div className="flex-1" />

      <div className="flex items-center gap-3">
        {/* Notifications */}
        <div className="relative">
          <button
            onClick={() => { setShowNotifications(!showNotifications); setShowUser(false); }}
            className="relative p-2 rounded-lg text-gray-400 hover:text-white transition-all"
            style={{ background: showNotifications ? 'rgba(255,255,255,0.08)' : 'transparent' }}
          >
            <Bell size={18} />
            <span className="absolute top-1.5 right-1.5 w-1.5 h-1.5 rounded-full"
              style={{ background: '#14b8a6', boxShadow: '0 0 6px rgba(20,184,166,0.8)' }} />
          </button>

          <AnimatePresence>
            {showNotifications && (
              <motion.div
                initial={{ opacity: 0, y: 8, scale: 0.97 }}
                animate={{ opacity: 1, y: 0, scale: 1 }}
                exit={{ opacity: 0, y: 8, scale: 0.97 }}
                transition={{ duration: 0.15 }}
                className="absolute right-0 mt-2 w-72 rounded-xl shadow-2xl overflow-hidden py-1 z-50"
                style={{ background: 'rgba(15,25,50,0.95)', border: '1px solid rgba(255,255,255,0.08)', backdropFilter: 'blur(16px)' }}
              >
                <div className="px-4 py-2.5 text-sm font-semibold text-white"
                  style={{ borderBottom: '1px solid rgba(255,255,255,0.06)' }}>
                  Notifications
                </div>
                <div className="p-6 text-center text-sm" style={{ color: '#64748b' }}>
                  Aucune nouvelle notification.
                </div>
                <div className="px-4 py-2 text-center text-xs" style={{ color: '#64748b', borderTop: '1px solid rgba(255,255,255,0.06)' }}>
                  Tout est à jour ✓
                </div>
              </motion.div>
            )}
          </AnimatePresence>
        </div>

        <div className="w-px h-6" style={{ background: 'rgba(255,255,255,0.08)' }} />

        {/* User menu */}
        <div className="relative">
          <button
            onClick={() => { setShowUser(!showUser); setShowNotifications(false); }}
            className="flex items-center gap-2.5 px-3 py-1.5 rounded-xl transition-all"
            style={{ background: showUser ? 'rgba(255,255,255,0.08)' : 'transparent' }}
          >
            <div className="w-8 h-8 rounded-full flex items-center justify-center text-white text-xs font-bold flex-shrink-0"
              style={{ background: 'linear-gradient(135deg, #14b8a6, #3b82f6)' }}>
              {(user?.prenom || user?.login || '?')[0]?.toUpperCase()}
            </div>
            <div className="hidden sm:block text-left">
              <p className="text-sm font-medium text-white leading-none">{user?.prenom} {user?.nom}</p>
              <p className="text-xs mt-0.5" style={{ color: '#14b8a6' }}>{user?.profil?.libelle || 'Membre'}</p>
            </div>
            <ChevronDown size={14} className="text-gray-500" />
          </button>

          <AnimatePresence>
            {showUser && (
              <motion.div
                initial={{ opacity: 0, y: 8, scale: 0.97 }}
                animate={{ opacity: 1, y: 0, scale: 1 }}
                exit={{ opacity: 0, y: 8, scale: 0.97 }}
                transition={{ duration: 0.15 }}
                className="absolute right-0 mt-2 w-48 rounded-xl shadow-2xl overflow-hidden py-1 z-50"
                style={{ background: 'rgba(15,25,50,0.95)', border: '1px solid rgba(255,255,255,0.08)', backdropFilter: 'blur(16px)' }}
              >
                <button
                  onClick={logout}
                  className="w-full flex items-center gap-2.5 px-4 py-2.5 text-sm text-red-400 hover:bg-red-500/10 transition-all"
                >
                  <LogOut size={15} />
                  Déconnexion
                </button>
              </motion.div>
            )}
          </AnimatePresence>
        </div>
      </div>
    </header>
  );
};

export default Topbar;
