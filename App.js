import { StyleSheet, Text, View } from 'react-native';
import Oyun from './Oyun';
import { LinearGradient } from 'expo-linear-gradient';

export default function App() {
  return (
    <LinearGradient colors={['#3498db','#ffffff']} style={styles.container}>
      <View style={styles.overlay}>
        <Oyun/>
      </View>
    </LinearGradient>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  overlay:{
    flex:1,
    backgroundColor:'rgba(255,255,255,0.1)',
    justifyContent:'center',
    alignItems:'center'
  }
});