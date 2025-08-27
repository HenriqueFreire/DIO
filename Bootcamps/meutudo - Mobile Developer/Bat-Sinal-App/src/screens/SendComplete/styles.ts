import { StyleSheet } from 'react-native';
import { theme } from '../../theme';

export const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: theme.colors.primary,
    padding: theme.metrics.basePadding,
  },

  textContainer: {
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 15,
  },

  title: {
    fontSize: theme.fonts.size.large,
    fontWeight: 'bold',
    marginBottom: 20,
    textAlign: 'center',
  },
  message: {
    fontSize: theme.fonts.size.medium,
    textAlign: 'center',
    marginBottom: 30,
  },
});
