import { View, Text, StyleSheet, TouchableOpacity, Alert } from 'react-native'
import React, { useState, useEffect } from 'react'
import OyunTahtasi from './OyunTahtasi'

const Oyun = () => {
    const initialBoard = [
        ['', '', '',],
        ['', '', '',],
        ['', '', '',]

    ];
    const [board,setBoard]=useState(initialBoard);
    const [player,setPlayer]=useState('X');
    const [winner,setWinner]=useState('');

    useEffect(() => {
    checkWinner();

    }, [board]);
    const tiklama = (rowIndex,cellIndex) => {
        if(board[rowIndex][cellIndex]===''&&!winner){
            const newBoard =[...board];
            newBoard[rowIndex][cellIndex] = player;

            setBoard(newBoard);
            setPlayer(player==='X'?'O':'X');
        }
    };
    const checkWinner=() => {
        //satır kontrolü
        for(let i=0;i<3;i++){
            if(board[i][0]!==''&&board[i][0]===board[i][1]&&board[i][0]===[1][2]){
                setWinner(board[i][0]);
                break;
            }
        }
        //sütun kontrolü
        for(let i=0;i<3;i++){
            if(board[0][i] !==''&&board[0][i]===board[1][i]&&board[0][i]===board[2][i]){
                setWinner(board[0][i]);
                break;
            }
        }
        if(board[0][0!==''&&board[0][0]===board[1][2]&&board[0][0]===board[2][2]]){
            setWinner(board[0][0]);

        } else if (board[0][2]!==''&& board[0][2]===board[1][1]&&board[0][2]===board[2][0]){
            setWinner(board[0][2]);
        }
    };
    const oyunTekrari=()=>{
        setBoard(initialBoard);
        setPlayer('X');
        setWinner('');
    };
    useEffect(()=>{
       if(winner){
           Alert.alert(`Oyuncu ${winner} Kazandı`,'',[{text:'OK',onPress:oyunTekrari}]);
       } 
    },[winner]);

    useEffect(()=>{
        if(!winner){
            const isBoardFull=board.every((row)=>row.every((cell)=>cell!==''));
            if(isBoardFull){
                Alert.alert('Berabere','',[{text:'OK',onPress:oyunTekrari}])
            }
        }
    },[board]);
    return (
        <View style={styles.container}>
            <Text style={styles.title}>Tic Tac Toe</Text>
            <OyunTahtasi board={board} onPress={tiklama} />
            <TouchableOpacity style ={styles.resetButton}
            onPress={oyunTekrari}
            >
                <Text style = {styles.resetButton}>Tekrarla</Text>

            </TouchableOpacity>
        </View>
    )
}

export default Oyun

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center'
        //justifyContent: 'center',
    },
    title:{
        fontSize:30,
        fontWeight:'bold',
        marginBottom:20,
    },
    resetButton:{
        backgroundColor:'rgba(255,255,255,0.1)',
        padding:10,
        borderRadius:5,
        marginTop:10,

    },
    resetButtonText:{
        color:'#fff',
        fontSize:20,
        fontWeight:'bold',
    }
});