import React, { useContext } from 'react';
import { View, ActivityIndicator, Text } from 'react-native';
import { ProfileHeader } from '../../components/ProfileHeader';
import { Button } from '../../components/Button';
import { StarRating } from '../../components/StarRating';
import { styles } from './styles';
import { UserContext } from '../../contexts/UserContext';

export function Home({ navigation }: any) {
  const { user, loading } = useContext(UserContext);

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

      <View style={styles.skillsContainer}>
        {user?.languages && user.languages.map(lang => {
          const starRating = Math.min(5, Math.floor(lang.percentage / 2)); // Cada estrela = 2%
          return (
            <View key={lang.name} style={styles.skillItem}>
              <Text style={styles.skillName}>{lang.name}</Text>
              <StarRating rating={starRating} />
            </View>
          );
        })}
      </View>

      <Button 
        title="Ir para Contato"
        onPress={() => navigation.navigate('Contact')}
        iconName="arrow-right"
      />
    </View>
  );
}