import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import { StatusBar } from 'expo-status-bar';

import { Home } from './src/screens/Home';
import { Register } from './src/screens/Register';
import { SendComplete } from './src/screens/SendComplete';

const Stack = createStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <StatusBar style="auto" />
      <Stack.Navigator initialRouteName="Home">
        <Stack.Screen name="Home" component={Home} options={{ headerShown: false }} />
        <Stack.Screen name="Register" component={Register} options={{ headerShown: false }} />
        <Stack.Screen name="SendComplete" component={SendComplete} options={{ headerShown: false }} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}