import React from 'react';
import { View, Text } from 'react-native';
import { styles } from './styles';

interface StarRatingProps {
  rating: number;
}

export function StarRating({ rating }: StarRatingProps) {
  const stars = [];
  for (let i = 1; i <= 5; i++) {
    stars.push(
      <Text key={i} style={i <= rating ? styles.filledStar : styles.emptyStar}>
        ★
      </Text>
    );
  }

  return <View style={styles.starContainer}>{stars}</View>;
}