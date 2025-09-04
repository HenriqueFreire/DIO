import React from 'react';
import { AppRoutes } from './src/navigation';
import { UserProvider } from './src/contexts/UserContext';

export default function App() {
  return (
    <UserProvider>
      <AppRoutes />
    </UserProvider>
  );
}