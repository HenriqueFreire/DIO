import React, { createContext, useState, useEffect, ReactNode } from 'react';

interface RepoData {
  id: number;
  name: string;
  description: string | null;
  html_url: string;
  language: string | null;
  stargazers_count: number;
  forks_count: number;
}

interface Language {
  name: string;
  percentage: number;
}

interface UserData {
  name: string;
  avatar_url: string;
  bio: string;
  repos: RepoData[];
  languages: Language[];
}

interface UserContextData {
  user: UserData | null;
  loading: boolean;
}

export const UserContext = createContext<UserContextData>({} as UserContextData);

const GITHUB_TOKEN = process.env.EXPO_PUBLIC_GITHUB_TOKEN; // Acessa a variável de ambiente

export function UserProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<UserData | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function loadUserData() {
      try {
        console.log('GITHUB_TOKEN lido:', GITHUB_TOKEN ? 'Sim' : 'Não', GITHUB_TOKEN ? GITHUB_TOKEN.substring(0, 5) + '...' : 'Nenhum');
        const headers = GITHUB_TOKEN ? { Authorization: `token ${GITHUB_TOKEN}` } : {};

        const userResponse = await fetch('https://api.github.com/users/HenriqueFreire', { headers });
        const userData = await userResponse.json();

        if (userResponse.status === 403) {
          console.error("Erro 403: Limite de taxa do GitHub atingido ou token inválido.");
          setLoading(false);
          return;
        }

        // Busca os repositórios
        const reposResponse = await fetch(userData.repos_url, { headers });
        const reposData: RepoData[] = await reposResponse.json();

        // Busca linguagens de cada repositório em paralelo
        const languagePromises = reposData.map((repo: any) =>
          fetch(repo.languages_url, { headers }).then(res => res.json())
        );
        const languagesPerRepo = await Promise.all(languagePromises);

        const totalLanguages: { [key: string]: number } = {};
        let totalBytes = 0;
        languagesPerRepo.forEach(languages => {
          for (const lang in languages) {
            totalBytes += languages[lang];
            if (totalLanguages[lang]) {
              totalLanguages[lang] += languages[lang];
            } else {
              totalLanguages[lang] = languages[lang];
            }
          }
        });

        // Calcula a porcentagem e formata os dados
        const languagesWithPercentage = Object.keys(totalLanguages)
          .map(lang => ({
            name: lang,
            percentage: (totalLanguages[lang] / totalBytes) * 100,
          }))
          .sort((a, b) => b.percentage - a.percentage)
          .slice(0, 5); // Pega as 5 principais

        setUser({
          name: userData.name,
          avatar_url: userData.avatar_url,
          bio: userData.bio,
          repos: reposData,
          languages: languagesWithPercentage,
        });

      } catch (error) {
        console.error("Erro ao buscar dados do GitHub:", error);
      } finally {
        setLoading(false);
      }
    }

    loadUserData();
  }, []);

  return (
    <UserContext.Provider value={{ user, loading }}>
      {children}
    </UserContext.Provider>
  );
}