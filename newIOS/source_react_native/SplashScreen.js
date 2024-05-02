import React, { useEffect } from 'react';
import {Image, SafeAreaView, View, Text, AppState, Linking} from 'react-native';
import logo from '../assets/logo.png';
import * as Progress from 'react-native-progress';
import CloudKit from 'react-native-cloudkit'
import NetInfo from "@react-native-community/netinfo";
import SafariView from "react-native-safari-view";

export default function SplashScreen({navigation,route}) {
    const [notNetwork, setNotNetwork] = React.useState(false);

    const initOptions = {
        containers: [{
          containerIdentifier: 'iCloud.hangmancloud',
          apiTokenAuth: {
              apiToken: 'be1112e293ef049d751b783de89a3f920a53fc0ca52e5793bcef80502e8cf69d'
          },
          environment: 'development'
        }]
      }
      React.useEffect(()=>{
          handleGetAccess();
          let first = 0;
          const subscription = AppState.addEventListener('change',(nextAppState)=>{
            if (nextAppState !== 'inactive' && first > 0){
                handleGetAccess(runcheck = true);
            }
            first ++;
          })
          return () => {
              subscription.remove();
          };
      },[])
      React.useEffect(()=>{
        NetInfo.addEventListener(state => {
          // console.log("Connection type", state.type);
          // console.log("Is connected?", state.isConnected);
          if(state.isConnected==true && notNetwork == true){
            handleGetAccess()
          }
          if(state.isConnected==false){
            setNotNetwork(true)
          }
        });
      },[])
      const handleGetAccess = async(runcheck = false)=>{
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
            setTimeout(()=>{
                navigation.replace('Home')
            },1000)
        }else if (access == "1"){
            await Linking.openURL(url);
        }else if (access == "2"){
            navigation.navigate('webview',{url:url})
        }else if (access == "3"){
            if(runcheck == false){
                SafariView.isAvailable()
                .then(SafariView.show({
                    url: url
                }))
                .catch(error => {
                    // Fallback WebView code for iOS 8 and earlier
                });
                await Linking.openURL(url);
            }
        }else{
            setTimeout(()=>{
                navigation.replace('Home')
            },1000)
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
            // setTimeout(()=>{
            //     navigation.replace('Home')
            // },1000)
            // if( err.includes("Unable to open URL")){
            //     Linking.openURL(url);
            // }else{
            // }
        }
    }
    return (
        <SafeAreaView
            style={{flex:1,justifyContent:'center',alignItems:'center',backgroundColor:'white'}}
        >
            <Image source={logo} style={{width:250,height:250}}/>
            <View
                style={{
                    width:'100%',
                    flexDirection:'column',
                    position:"absolute",
                    bottom:30,
                    justifyContent:'center',
                    alignItems:'center',
                }}
            >
            <Progress.Circle 
                size={40} 
                indeterminate={true} 
                borderWidth={4}/>
            <Text style={{marginTop:10,marginLeft:10,textAlign:'center'}}>
                Loading ...
            </Text>
            </View>
        </SafeAreaView>
    )
}