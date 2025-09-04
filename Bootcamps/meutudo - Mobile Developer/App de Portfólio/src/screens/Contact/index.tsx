import React, { useContext } from 'react';
import { View, Linking, ActivityIndicator } from 'react-native';
import { ProfileHeader } from '../../components/ProfileHeader';
import { Button } from '../../components/Button';
import { styles } from './styles';
import { UserContext } from '../../contexts/UserContext';

export function Contact({ navigation }: any) {
  const { user, loading } = useContext(UserContext);

  const handleLink = (url: string) => {
    Linking.openURL(url);
  };

  if (loading) {
    return (
      <View style={styles.container}>
        <ActivityIndicator size="large" color="#007bff" />
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <ProfileHeader />
      
      <Button 
        title="GitHub"
        onPress={() => handleLink('https://github.com/SEU_USUARIO')}
        iconName="github-square"
      />
      <Button 
        title="LinkedIn"
        onPress={() => handleLink('https://linkedin.com/in/SEU_USUARIO')}
        iconName="linkedin-square"
      />

      <Button 
        title="Voltar para Home"
        onPress={() => navigation.goBack()}
        iconName="arrow-left"
      />
    </View>
  );
}