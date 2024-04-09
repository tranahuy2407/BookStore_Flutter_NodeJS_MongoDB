const express = require("express");
const mongoose = require("mongoose");
const adminRouter = require("./routers/admin");
const authRouter = require("./routers/auth");
const productRouter = require("./routers/product");
const userRouter = require("./routers/user");
const couponRouter = require("./routers/coupon");


const PORT = process.env.PORT || 3000;
const app = express();
const DB = "mongodb+srv://tranahuy247:Q4wWikq5WMnL8yrE@cluster0.fblnm5k.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);
app.use(couponRouter);

mongoose
  .connect(DB)
  .then(() => {
    console.log("Kết nối thành công !");
  })
  .catch((e) => {
    console.log(e);
  });
app.listen(PORT,"0.0.0.0", () => {
  console.log(`Kết nối tại port ${PORT}`);
});
