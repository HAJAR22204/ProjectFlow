import { BrowserRouter, Routes, Route } from 'react-router-dom';
import { Toaster } from 'react-hot-toast';
import { AuthProvider } from './context/AuthContext';
import { PrivateRoute } from './guards/PrivateRoute';
import Layout from './layouts/Layout';
import Login from './pages/Login';
import Dashboard from './pages/Dashboard';
import Projets from './pages/Projets';
import Phases from './pages/Phases';
import Factures from './pages/Factures';
import Organismes from './pages/Organismes';
import Employes from './pages/Employes';
import Livrables from './pages/Livrables';
import Affectations from './pages/Affectations';
import Profils from './pages/Profils';
import Documents from './pages/Documents';
import Reporting from './pages/Reporting';
import ChangePassword from './pages/ChangePassword';
import NotFound from './pages/NotFound';
import AccessDenied from './pages/AccessDenied';

function App() {
  return (
    <BrowserRouter>
      <AuthProvider>
        <Routes>
          <Route path="/login" element={<Login />} />

          <Route element={<PrivateRoute />}>
            <Route element={<Layout />}>
              <Route path="/" element={<Dashboard />} />

              {/* ADMIN : Gestion des comptes */}
              <Route element={<PrivateRoute allowedRoles={['ADMINISTRATEUR', 'ADMIN']} />}>
                <Route path="/employes" element={<Employes />} />
                <Route path="/profils" element={<Profils />} />
              </Route>

              {/* SECRETAIRE, DIRECTEUR, CHEF_PROJET, ADMIN : Gestion structurelle et Organismes */}
              <Route element={<PrivateRoute allowedRoles={['ADMINISTRATEUR', 'ADMIN', 'CHEF_PROJET', 'DIRECTEUR', 'SECRETAIRE']} />}>
                <Route path="/projets" element={<Projets />} />
                <Route path="/organismes" element={<Organismes />} />
              </Route>

              {/* FINANCE : Factures et Reporting */}
              <Route element={<PrivateRoute allowedRoles={['ADMINISTRATEUR', 'ADMIN', 'DIRECTEUR', 'COMPTABLE']} />}>
                <Route path="/factures" element={<Factures />} />
                <Route path="/reporting" element={<Reporting />} />
              </Route>

              {/* PHASES : Opérationnel et Consultation */}
              <Route element={<PrivateRoute allowedRoles={['ALL']} />}>
                <Route path="/phases" element={<Phases />} />
              </Route>

              {/* OPÉRATIONNEL AUTRE : Livrables, Affectations, Documents */}
              <Route element={<PrivateRoute allowedRoles={['ALL']} />}>
                <Route path="/affectations" element={<Affectations />} />
                <Route path="/livrables" element={<Livrables />} />
                <Route path="/documents" element={<Documents />} />
              </Route>

              <Route path="/change-password" element={<ChangePassword />} />
              <Route path="/access-denied" element={<AccessDenied />} />
              <Route path="*" element={<NotFound />} />
            </Route>
          </Route>
        </Routes>
      </AuthProvider>
      <Toaster position="top-right" />
    </BrowserRouter>
  );
}

export default App;