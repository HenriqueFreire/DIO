import { StyleSheet } from 'react-native';
import { theme } from '../../theme';

export const styles = StyleSheet.create({
  input: {
    height: 40,
    borderColor: theme.colors.secondary ,
    borderWidth: 1,
    borderRadius: theme.metrics.baseRadius,
    paddingHorizontal: theme.metrics.basePadding,
    marginVertical: theme.metrics.baseMargin,
    width: '100%',
    fontWeight: 'bold',
  },
});
