const express = require("express");
const couponRouter = express.Router();
const Coupon = require("../models/coupon");

couponRouter.post("/api/apply-coupon", async (req, res) => {
  try {
    const { couponCode } = req.body;
    const coupon = await Coupon.findOne({ name: couponCode });
    if (!coupon) {
      return res.status(404).json({ message: "Không tìm thấy mã giảm giá." });
    }
    const { value: discountPercentage } = coupon;
    res.status(200).json({
      success: true,
      message: "Mã giảm giá hợp lệ.",
      discountPercentage,
    });
  } catch (error) {
    console.error("Lỗi khi áp dụng mã giảm giá:", error);
    res.status(500).json({ message: "Đã xảy ra lỗi khi xử lý yêu cầu." });
  }
});

module.exports = couponRouter;
