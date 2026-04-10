import React from 'react';
import { Outlet } from 'react-router-dom';
import Sidebar from './Sidebar';
import Topbar from './Topbar';
import { motion } from 'framer-motion';

const Layout: React.FC = () => {
  return (
    <div className="flex h-screen bg-[#eaeded] overflow-hidden text-[#0f1111]">
      <Sidebar />

      <div className="flex flex-col flex-1 min-w-0 overflow-hidden relative">
        {/* On a supprimé les div de background glow indigo */}
        <Topbar />

        <main className="flex-1 overflow-y-auto overflow-x-hidden custom-scrollbar p-6 lg:p-8 z-10 relative">
          <motion.div
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.3 }}
            className="max-w-7xl mx-auto"
          >
            <Outlet />
          </motion.div>
        </main>
      </div>
    </div>
  );
};

export default Layout;