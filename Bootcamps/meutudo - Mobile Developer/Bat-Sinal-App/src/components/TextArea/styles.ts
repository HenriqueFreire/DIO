import { StyleSheet } from 'react-native';
import { theme } from '../../theme';

export const styles = StyleSheet.create({
  textArea: {
    borderWidth: 1,
    borderColor: theme.colors.secondary,
    borderRadius: theme.metrics.baseRadius,
    padding: theme.metrics.basePadding,
    minHeight: 100,
    textAlignVertical: 'top',
    width: '100%',
    marginVertical: theme.metrics.baseMargin,
    fontWeight: 'bold',
  },
});
