import React, { useState } from 'react';
import { useForm } from 'react-hook-form';
import { motion } from 'framer-motion';
import { Briefcase } from 'lucide-react';
import { useNavigate } from 'react-router-dom';
import toast from 'react-hot-toast';
import { useAuth } from '../context/AuthContext';
import { authService } from '../services/auth.service';
import type { LoginRequest } from '../types/api-requests';

const Login: React.FC = () => {
  const { register, handleSubmit, formState: { errors } } = useForm<LoginRequest>();
  const [isLoading, setIsLoading] = useState(false);
  const { login } = useAuth();
  const navigate = useNavigate();

  const onSubmit = async (data: LoginRequest) => {
    setIsLoading(true);
    try {
      const response = await authService.login(data);
      const user = {
        id: response.employeId,
        login: response.login,
        nom: response.nom,
        prenom: response.prenom,
        email: '',
        matricule: '',
        profil: {
          id: 0,
          code: response.profil,
          libelle: response.profil
        }
      };
      login(response.token, user);
      toast.success('Connexion réussie !');
      navigate('/');
    } catch (error: any) {
      console.error(error);
      toast.error(error.response?.data?.message || 'Échec de la connexion. Vérifiez vos identifiants.');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex flex-col items-center justify-center bg-[#ffffff] p-4">
      {/* Logo ProjetFlow style Amazon */}
      <div className="mb-8 text-center">
        <Briefcase size={40} className="text-[#232f3e] mx-auto mb-2" />
        <h1 className="text-2xl font-bold text-[#0f1111]">ProjetFlow</h1>
      </div>

      {/* Carte d'authentification */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        className="w-full max-w-[350px] border border-[#ddd] p-6 rounded-lg shadow-sm bg-white"
      >
        <h2 className="text-2xl font-normal mb-4 text-[#0f1111]">S'identifier</h2>

        <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
          <div>
            <label className="block text-sm font-bold mb-1 text-[#0f1111]">Identifiant</label>
            <input
              type="text"
              className="w-full border border-[#a6a6a6] rounded-sm p-2 focus:border-[#e77600] focus:shadow-[0_0_3px_2px_rgba(228,121,17,.5)] outline-none transition-all text-black"
              {...register('login', { required: "L'identifiant est requis" })}
            />
            {errors.login && <p className="text-xs text-[#b12704] mt-1">{errors.login.message}</p>}
          </div>

          <div>
            <label className="block text-sm font-bold mb-1 text-[#0f1111]">Mot de passe</label>
            <input
              type="password"
              className="w-full border border-[#a6a6a6] rounded-sm p-2 focus:border-[#e77600] focus:shadow-[0_0_3px_2px_rgba(228,121,17,.5)] outline-none transition-all text-black"
              {...register('password', { required: "Le mot de passe est requis" })}
            />
            {errors.password && <p className="text-xs text-[#b12704] mt-1">{errors.password.message}</p>}
          </div>

          <button
            type="submit"
            disabled={isLoading}
            className="w-full bg-[#ffd814] border border-[#a88734] hover:bg-[#f7dfa1] py-1.5 rounded-sm text-sm shadow-sm font-medium transition-colors text-black"
          >
            {isLoading ? "Chargement..." : "Continuer"}
          </button>
        </form>

        <p className="text-xs mt-4 text-[#565959] leading-tight">
          En continuant, vous acceptez les conditions d'utilisation et la politique de confidentialité du système ProjetFlow.
        </p>
      </motion.div>

      {/* Pied de page Aide */}
      <div className="mt-6 w-full max-w-[350px] flex items-center gap-2">
        <div className="h-px bg-[#e7e7e7] flex-1"></div>
        <span className="text-xs text-[#767676]">Aide à la connexion ?</span>
        <div className="h-px bg-[#e7e7e7] flex-1"></div>
      </div>

      <button className="mt-3 w-full max-w-[350px] bg-[#f0f2f2] border border-[#adb1b1] hover:bg-[#e7e9ec] py-1 rounded-sm text-sm shadow-sm transition-colors text-black">
        Contacter l'administrateur
      </button>
    </div>
  );
};

export default Login;