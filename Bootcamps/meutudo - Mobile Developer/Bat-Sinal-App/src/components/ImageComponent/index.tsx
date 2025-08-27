import React from 'react';
import { Image, ImageProps, ImageSourcePropType } from 'react-native';
import { styles } from './styles';

interface ImageComponentProps extends ImageProps {
  source: ImageSourcePropType;
  width?: number;
  height?: number;
}

export const ImageComponent: React.FC<ImageComponentProps> = ({ source, style, width, height, ...rest }) => {
  return (
    <Image
      source={source}
      style={[styles.image, style, { width, height }]}
      {...rest}
    />
  );
};
