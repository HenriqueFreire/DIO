import { StyleSheet } from 'react-native';
import { theme } from '../../theme';

export const styles = StyleSheet.create({
  button: {
    backgroundColor: theme.colors.primary,
    padding: theme.metrics.basePadding,
    borderRadius: 50,
    alignItems: 'center',
    marginVertical: theme.metrics.baseMargin,
    borderColor: theme.colors.black,
    borderWidth: 3,
  },
  buttonText: {
    color: theme.colors.black,
    fontSize: theme.fonts.size.large,
    fontWeight: 'bold',
  },
});
