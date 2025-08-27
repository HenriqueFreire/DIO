import React from 'react';
import { Animated } from 'react-native';
import { BatmanLogo } from '../BatmanLogo';

interface SvgImageComponentProps {
  width?: number;
  height?: number;
  scale?: Animated.Value;
  fill?: Animated.AnimatedInterpolation<string | number>;
}

export const SvgImageComponent: React.FC<SvgImageComponentProps> = ({ width, height, scale, fill }) => {
  return (
    <Animated.View style={scale ? { transform: [{ scale }] } : {}}>
      <BatmanLogo width={width} height={height} fill={fill} />
    </Animated.View>
  );
};
