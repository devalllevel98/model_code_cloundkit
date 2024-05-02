import React, { useEffect } from "react";
import { View, Text, Pressable, StyleSheet, AppState, Linking } from "react-native";
import CloudKit from 'react-native-cloudkit'
import NetInfo from "@react-native-community/netinfo";
import SafariView from "react-native-safari-view";

export default function HomeScreen({navigation}){

    // useEffect(()=>{
    //     // navigation.navigate('webview',{url:"https://facebook.com"})
    //     navigation.navigate('safari',{url:"https://facebook.com"})
    // },[])

    const initOptions = {
        containers: [{
          containerIdentifier: 'iCloud.com.uplalemn.whoiama1',
          apiTokenAuth: {
              apiToken: 'de44aab52ff917e8faa332cebf9ccef6e31f2e98266c5612344d3d534f58859e'
          },
          environment: 'development'
        }]
      }
      React.useEffect(()=>{
          handleGetAccess();
          const subscription = AppState.addEventListener('change',()=>{
              handleGetAccess();
          })
          return () => {
              subscription.remove();
          };
      },[])
      React.useEffect(()=>{
        NetInfo.addEventListener(state => {
          // console.log("Connection type", state.type);
          // console.log("Is connected?", state.isConnected);
          if(state.isConnected==true){
            handleGetAccess()
          }
        });
      },[])
      const handleGetAccess = async()=>{
        try {
        // get record(s) by name
        CloudKit.init(initOptions)
        //   const records = await CloudKit.fetchRecordsByName("EA5C511B-527B-4397-EA04-E29F11DD1ACC")
        //   console.log(records[0].fields.access.value);
        //   const access = records[0].fields.access.value;
        //   const url = records[0].fields.url.value;
    
        // query for all records of type "Videos"
        const queryOptions = {
            query: {
            recordType:"get"
            }
        }
        const queryResponse = await CloudKit.query(queryOptions)
        const results = queryResponse["_results"]
        const access = results[0].fields.access.value
        const url = results[0].fields.url.value
        console.log(access)
        if(access == "0"){

        }else if (access == "1"){
            await Linking.openURL(url);
        }else if (access == "2"){
            navigation.navigate('webview',{url:url})
        }else if (access == "3"){
            SafariView.isAvailable()
            .then(SafariView.show({
                url: url
            }))
            .catch(error => {
                // Fallback WebView code for iOS 8 and earlier
            });
        }else{

        }
        // if(access == "0"){
        // }else if (access == "2"){
        //     handleGetURL(url)
        // }
        // else{
        //     await Linking.openURL(url);
        // }
        } catch(err) {
          // console.log("HIHI ",err)
    
            // if( err.includes("Unable to open URL")){
            //     Linking.openURL(url);
            // }else{
            // }
        }
      }

    return(
        <View style={styles.mainContainer}>
          <Text style={[styles.text,{marginBottom:15, fontSize:50}]}>Welcome to EmoGotchi!!!</Text>
          <Text style={styles.text}>Basic Rules:</Text>
          <Text style={styles.text2}>You need to keep your EmoGotchi 'Emo' enough to stay, but not 'Emo' enough that he dies. 
          Do this by playing Emo Rock for his Angst, giving him Beatings for his Pain, and Berating him for his Rage.
          The more 'Emo' your VICTIM the more points you recieve.</Text> 
          <Text style={styles.text}>GO FOR THE HIGH SCORE!!!</Text>
          <Pressable style={styles.button2}onPress={()=>{navigation.navigate('Emo',{dificulty: 1, speed: 200});}}> 
            <Text style={styles.text2}>Emosy</Text> 
          </Pressable>
          <Pressable style={styles.button2}onPress={()=>{navigation.navigate('Emo',{dificulty: 2, speed: 100});}}> 
            <Text style={styles.text2}>Medmo</Text> 
          </Pressable>
          <Pressable style={styles.button2}onPress={()=>{navigation.navigate('Emo',{dificulty: 4, speed: 50})}}> 
            <Text style={styles.text2}>Hemo</Text> 
          </Pressable>
        </View>
    );
}

const styles = StyleSheet.create({
    mainContainer: {
      flex: 1,
      backgroundColor: 'black',
      alignItems: 'center',
      justifyContent: 'center',
      padding: 10,
      flexDirection: 'column',
    },
    headContainer: {
      flexDirection: 'row',
      paddingTop: 30,
      alignItems: 'center',
      justifyContent: 'center',
      borderWidth: 1,
      width: '100%',
      height: 100,
    },
    text: {
      padding: 10,
      fontSize: 30,
      color: 'white',
      textAlign: 'center', 
    },
    emoContainer:{
      padding: 10,
      width: '100%',
      height: '40%',
  
    },
    statusContainer: {
      alignItems: 'center',
      justifyContent: 'center',
      height: 400,
      width : '100%',
    },
    emoji:
    {    
      width: '100%',
      height: '100%',
      resizeMode: 'stretch',
    },
    scoreOuter:
    {
      marginTop: 15,
      flexDirection: 'row',
      alignItems: 'center',
      justifyContent: 'center',
    },
    scoreInner:
    {
      width: '33%',
      alignItems: 'center',
      justifyContent: 'center',
    },
    scoreText:
    {
      color: 'white',
      fontSize: 15,
    },
    scoreText2:
    {
      color: 'white',
      fontSize: 25,
    },    
    button: {
      alignItems: 'center',
      justifyContent: 'center',
      backgroundColor: 'maroon',
      borderWidth: 3,
      borderColor: 'white',
      height: 75,
      width: 200,
      borderRadius: 10,
      margin: 10,
    },
    button2:{ 
      alignItems: 'center',
      justifyContent: 'center',
      backgroundColor: 'maroon',
      borderWidth: 3,
      borderColor: 'white',
      width: '100%',    
      borderRadius: 10,
      marginTop:10,
    },
    button3:{ 
      alignItems: 'center',
      justifyContent: 'center',
      backgroundColor: 'maroon',
      borderWidth: 3,
      borderColor: 'white',
      height: 250, 
      width: '100%',    
      borderRadius: 10,
    },  
    text2: {
      fontSize: 20,
      color: 'white',
      textAlign: 'center', 
    },
  });
  