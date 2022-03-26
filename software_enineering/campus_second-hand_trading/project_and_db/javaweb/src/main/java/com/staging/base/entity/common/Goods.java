package com.staging.base.entity.common;

import com.staging.base.annotion.ValidateEntity;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;

/**
 * 物品物品实体类
 *
 */
@Entity
@Table(name="barter_goods")
@EntityListeners(AuditingEntityListener.class)
public class Goods extends BaseEntity {

    public  static final int GOODS_STATUS_UP=1;//上架
    public  static final int GOODS_STATUS_DOWN=2;//下架
    public  static final int GOODS_STATUS_SOLD=3;//售出

    public  static final int GOODS_FLAG_ON=1;//擦亮
    public  static final int GOODS_FLAG_OFF=0;//不擦亮

    public  static final int GOODS_RECOMMEND_ON=1;//推荐
    public  static final int GOODS_RECOMMEND_OFF=0;//不推荐

    public  static final int GOODS_REVIEW_WAIT=0;//等待审核
    public  static final int GOODS_REVIEW_NO_PASS=1;//审核未通过
    public  static final int GOODS_REVIEW_PASS=2;//审核通过



    private static final long serialVersionUID = 1L;
    @ManyToOne
    @JoinColumn(name="student_id")
    private Student student;//所属学生

    @ValidateEntity(required=true,requiredLeng=true,minLength=1,maxLength=30,errorRequiredMsg="物品名称不能为空!",errorMinLengthMsg="物品名称长度需大于1!",errorMaxLengthMsg="物品名称长度不能大于30!")
    @Column(name="name",nullable=false,length=32)
    private String name;//物品名称

    @ManyToOne
    @JoinColumn(name="goods_category_id")
    private GoodsCategory goodsCategory;//物品分类

    @ValidateEntity(required=true,errorRequiredMsg = "请填写购买价格",requiredMinValue = true,errorMinValueMsg = "购买价格不能小于0")
    @Column(name="buy_price",nullable = false,length=8)
    private Float buyPrice;//购买价格

    @ValidateEntity(required=true,errorRequiredMsg = "请填写出售价格",requiredMinValue = true,errorMinValueMsg = "售出价格不能小于0")
    @Column(name="sell_price",nullable = false,length=8)
    private Float sellPrice;//售出价格

    @ValidateEntity(required=true,errorRequiredMsg = "请上传图片")
    @Column(name="photo",nullable = false,length=128)
    private String photo;//物品图片

    @Column(name="status",nullable=false,length=1)
    private Integer status;//物品状态,默认上架

    @Column(name="flag",nullable=false,length=1)
    private Integer flag;//是否擦亮

    @Column(name="recommend",nullable=false,length=1)
    private Integer recommend;//是否推荐

    @Column(name="review",nullable=false,length=1)
    private Integer review;//是否推荐

    @ValidateEntity(required=true,requiredLeng=true,minLength=1,maxLength=1000,errorRequiredMsg="物品详情描述不能为空!",errorMinLengthMsg="物品详情描述长度需大于1!",errorMaxLengthMsg="物品详情描述长度不能大于1000!")
    @Column(name="content",length=1024)
    private String content;//物品详情描述

    @Column(name="view_number",nullable=false,length=8)
    private Integer viewNumber=0;//物品浏览量

    public static int getGoodsStatusUp() {
        return GOODS_STATUS_UP;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public GoodsCategory getGoodsCategory() {
        return goodsCategory;
    }

    public void setGoodsCategory(GoodsCategory goodsCategory) {
        this.goodsCategory = goodsCategory;
    }

    public Float getBuyPrice() {
        return buyPrice;
    }

    public void setBuyPrice(Float buyPrice) {
        this.buyPrice = buyPrice;
    }

    public Float getSellPrice() {
        return sellPrice;
    }

    public void setSellPrice(Float sellPrice) {
        this.sellPrice = sellPrice;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getFlag() {
        return flag;
    }

    public void setFlag(Integer flag) {
        this.flag = flag;
    }

    public Integer getRecommend() {
        return recommend;
    }

    public void setRecommend(Integer recommend) {
        this.recommend = recommend;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getViewNumber() {
        return viewNumber;
    }

    public void setViewNumber(Integer viewNumber) {
        this.viewNumber = viewNumber;
    }

    public Integer getReview() {
        return review;
    }

    public void setReview(Integer review) {
        this.review = review;
    }

    @Override
    public String toString() {
        return "Goods{" +
            "student=" + student +
            ", name='" + name + '\'' +
            ", goodsCategory=" + goodsCategory +
            ", buyPrice=" + buyPrice +
            ", sellPrice=" + sellPrice +
            ", photo='" + photo + '\'' +
            ", status=" + status +
            ", flag=" + flag +
            ", recommend=" + recommend +
            ", review=" + review +
            ", content='" + content + '\'' +
            ", viewNumber=" + viewNumber +
            '}';
    }
}

