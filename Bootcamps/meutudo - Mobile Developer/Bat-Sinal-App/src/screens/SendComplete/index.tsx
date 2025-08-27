import React, { useEffect, useRef } from 'react';
import { View, Text, Animated } from 'react-native';
import { Button } from '../../components/Button';
import { SvgImageComponent } from '../../components/SvgImageComponent';
import { styles } from './styles';
import { theme } from '../../theme';

export const SendComplete = ({ navigation }) => {
  const colorAnimation = useRef(new Animated.Value(0)).current;
  const scaleAnimation = useRef(new Animated.Value(1)).current;

  useEffect(() => {
    Animated.loop(
      Animated.sequence([
        Animated.timing(colorAnimation, {
          toValue: 1,
          duration: 2000,
          useNativeDriver: false,
        }),
        Animated.timing(colorAnimation, {
          toValue: 0,
          duration: 2000,
          useNativeDriver: false,
        }),
      ])
    ).start();

    Animated.loop(
      Animated.sequence([
        Animated.timing(scaleAnimation, {
          toValue: 1.1,
          duration: 1000,
          useNativeDriver: true,
        }),
        Animated.timing(scaleAnimation, {
          toValue: 1,
          duration: 1000,
          useNativeDriver: true,
        }),
      ])
    ).start();
  }, []);

  const backgroundColor = colorAnimation.interpolate({
    inputRange: [0, 1],
    outputRange: [theme.colors.primary, theme.colors.secondary],
  });

  const buttonColor = colorAnimation.interpolate({
    inputRange: [0, 1],
    outputRange: [theme.colors.primary, theme.colors.secondary],
  });

  const textColor = colorAnimation.interpolate({
    inputRange: [0, 1],
    outputRange: [theme.colors.secondary, theme.colors.primary],
  });

  const buttonTextColor = colorAnimation.interpolate({
    inputRange: [0, 1],
    outputRange: [theme.colors.secondary, theme.colors.primary],
  });

  const buttonBorderColor = colorAnimation.interpolate({
    inputRange: [0, 1],
    outputRange: [theme.colors.secondary, theme.colors.primary],
  });

  const batmanLogoColor = colorAnimation.interpolate({
    inputRange: [0, 1],
    outputRange: [theme.colors.secondary, theme.colors.primary],
  });

  return (
    <Animated.View style={[styles.container, { backgroundColor }]}>
      <SvgImageComponent width={200} height={200} scale={scaleAnimation} fill={batmanLogoColor} />
      <View style={styles.textContainer}>
        <Animated.Text style={[styles.title, { color: textColor }]}>Bat-Sinal Ativado!</Animated.Text>
        <Animated.Text style={[styles.message, { color: textColor }]}>Em breve, o batman virá em seu socorro.</Animated.Text>
      </View>
      <Button
        title="Desativar Bat-Sinal"
        onPress={() => navigation.navigate('Home')}
        color={buttonColor}
        animatedTextColor={buttonTextColor}
        animatedBorderColor={buttonBorderColor}
      />
    </Animated.View>
  );
};

