import express from "express"
const app = express()

app.get("/",(req,res)=>{
    res.status(200).json("Request acepted")
})

app.listen((8001),()=>{
    console.log("Listening  to the port 8001")
})