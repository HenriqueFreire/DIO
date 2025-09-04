import React from 'react';
import { View } from 'react-native';
import { ProfileImage } from '../ProfileImage';
import { ProfileName } from '../ProfileName';
import { styles } from './styles';

export function ProfileHeader() {
  return (
    <View style={styles.container}>
      <ProfileImage />
      <ProfileName />
    </View>
  );
}