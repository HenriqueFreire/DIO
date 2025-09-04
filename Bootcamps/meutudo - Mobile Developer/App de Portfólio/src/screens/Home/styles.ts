import { StyleSheet } from 'react-native';

export const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: '#f0f0f0',
    paddingTop: 190, // Espaço para o cabeçalho fixo
    paddingHorizontal: 20,
  },
  skillsContainer: {
    width: '100%',
    marginVertical: 20,
  },
  skillItem: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between', // Alinha nome e estrelas nas extremidades
    marginBottom: 10,
    paddingHorizontal: 10,
  },
  skillName: {
    fontSize: 16,
    fontWeight: 'bold',
    flex: 1, // Permite que o nome ocupe o espaço restante
  },
});