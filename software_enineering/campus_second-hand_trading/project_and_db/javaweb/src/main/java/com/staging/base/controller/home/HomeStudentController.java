package com.staging.base.controller.home;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.staging.base.annotion.ValidateEntity;
import com.staging.base.bean.CodeMsg;
import com.staging.base.bean.Result;
import com.staging.base.constant.SessionConstant;
import com.staging.base.dao.common.GoodsDao;
import com.staging.base.entity.common.Comment;
import com.staging.base.entity.common.Goods;
import com.staging.base.entity.common.Student;
import com.staging.base.entity.common.WantedGoods;
import com.staging.base.service.common.*;
import com.staging.base.util.SessionUtil;
import com.staging.base.util.ValidateEntityUtil;
import com.sun.org.apache.bcel.internal.classfile.Code;
import com.sun.org.apache.regexp.internal.RE;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 学生中心控制器
 */
@RequestMapping("/home/student")
@Controller
public class HomeStudentController {
    @Autowired
    private GoodsCategoryService goodsCategoryService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private GoodsService goodsService;
    @Autowired
    private WantedGoodsService wantedGoodsService;
    @Autowired
    private CommentService commentService;
    /**
     * 学生登录主页
     * @param model
     * @return
     */
    @RequestMapping(value="/index", method = RequestMethod.GET)
    public String index(Model model){
        Student  loginedStudent = (Student)SessionUtil.get(SessionConstant.SESSION_STUDENT_LOGIN_KEY);
        model.addAttribute("goodsList",goodsService.findByStudent(loginedStudent));
        return "home/student/index";
    }

    /**
     * 修改个人信息提交表单
     * @param student
     * @return
     */
    @RequestMapping(value="/edit_info", method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> editInfo(Student student){
        Student  loginedStudent = (Student)SessionUtil.get(SessionConstant.SESSION_STUDENT_LOGIN_KEY);
        loginedStudent.setAcademy(student.getAcademy());
        loginedStudent.setGrade(student.getGrade());
        loginedStudent.setMobile(student.getMobile());
        loginedStudent.setNickname(student.getNickname());
        loginedStudent.setQq(student.getQq());
        loginedStudent.setSchool(student.getSchool());
        loginedStudent.setHeadPic(student.getHeadPic());
        if(studentService.save(loginedStudent) == null){
            return Result.error(CodeMsg.HOME_STUDENT_EDITINFO_ERROR);
        }
        return Result.success(true);
    }

    /**
     * 物品发布页面
     * @param model
     * @return
     */
    @RequestMapping(value = "publish",method = RequestMethod.GET)
    public String publish(Model model){
        return "home/student/publish";
    }


    /**
     * 商品发布表单提交
     * @param goods
     * @return
     */
    @RequestMapping(value="/publish", method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> publish(Goods goods){
        CodeMsg validate = ValidateEntityUtil.validate(goods);
        if (validate.getCode()!=CodeMsg.SUCCESS.getCode()){
            return Result.error(validate);
        }
        if (goods.getGoodsCategory()==null || goods.getGoodsCategory().getId()==null||goods.getGoodsCategory().getId().longValue()==-1){
            return Result.error(CodeMsg.HOME_STUDENT_PUBLISH_CATEGORY_EMPTY);
        }
        Student loginedStudent=(Student)SessionUtil.get(SessionConstant.SESSION_STUDENT_LOGIN_KEY);
        goods.setStudent(loginedStudent);
        if (goodsService.save(goods)==null){
            return Result.error(CodeMsg.HOME_STUDENT_PUBLISH_ERROR);
        }
        return Result.success(true);
    }

    /**
     * 商品编辑页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/edit_goods",method = RequestMethod.GET)
    public String publish(@RequestParam(name ="id",required = true)Long id, Model model)
    {
        Student loginedStudent=(Student)SessionUtil.get(SessionConstant.SESSION_STUDENT_LOGIN_KEY);
        Goods goods = goodsService.find(id, loginedStudent.getId());
        if (goods==null){
            model.addAttribute("msg","物品不存在");
            return "error/runtime_error";
        }
        model.addAttribute("goods",goods);
        return "home/student/edit_goods";
    }

    /**
     * 物品编辑表单提交
     * @param goods
     * @return
     */
    @RequestMapping(value="/edit_goods", method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> editGoods(Goods goods){
        CodeMsg validate = ValidateEntityUtil.validate(goods);
        if (validate.getCode()!=CodeMsg.SUCCESS.getCode()){
            return Result.error(validate);
        }
        if (goods.getGoodsCategory()==null || goods.getGoodsCategory().getId()==null||goods.getGoodsCategory().getId().longValue()==-1){
            return Result.error(CodeMsg.HOME_STUDENT_PUBLISH_CATEGORY_EMPTY);
        }
        Student loginedStudent=(Student)SessionUtil.get(SessionConstant.SESSION_STUDENT_LOGIN_KEY);
        Goods existGoods = goodsService.find(goods.getId(),loginedStudent.getId());
        if(existGoods == null){
            return Result.error(CodeMsg.HOME_STUDENT_GOODS_NO_EXIST);
        }
        existGoods.setBuyPrice(goods.getBuyPrice());
        existGoods.setContent(goods.getContent());
        existGoods.setGoodsCategory(goods.getGoodsCategory());
        existGoods.setName(goods.getName());
        existGoods.setPhoto(goods.getPhoto());
        existGoods.setSellPrice(goods.getSellPrice());
        existGoods.setRecommend(goods.getRecommend());

        if (goodsService.save(existGoods)==null){
            return Result.error(CodeMsg.HOME_STUDENT_GOODS_EDIT_ERROR);
        }
        return Result.success(true);
    }

    /**
     * 用户设置是否擦亮
     * @param id
     * @param flag
     * @return
     */
    @RequestMapping(value="/update_flag", method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> updateFlag(@RequestParam(name="id", required = true) Long id,
                                      @RequestParam(name="flag", required = true,defaultValue = "0")Integer flag) {
        Student loginedStudent=(Student)SessionUtil.get(SessionConstant.SESSION_STUDENT_LOGIN_KEY);
        Goods existGoods = goodsService.find(id,loginedStudent.getId());
        if(existGoods == null){
            return Result.error(CodeMsg.HOME_STUDENT_GOODS_NO_EXIST);
        }
        existGoods.setFlag(flag);
        if (goodsService.save(existGoods)==null){
            return Result.error(CodeMsg.HOME_STUDENT_GOODS_EDIT_ERROR);
        }
        return Result.success(true);
    }

    /**
     * 修改物品状态
     * @param id
     * @param status
     * @return
     */
    @RequestMapping(value="/update_status", method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> updateStatus(@RequestParam(name="id", required = true) Long id,
                                      @RequestParam(name="status", required = true,defaultValue = "2")Integer status) {
        Student loginedStudent=(Student)SessionUtil.get(SessionConstant.SESSION_STUDENT_LOGIN_KEY);
        Goods existGoods = goodsService.find(id,loginedStudent.getId());
        if(existGoods == null){
            return Result.error(CodeMsg.HOME_STUDENT_GOODS_NO_EXIST);
        }
        existGoods.setStatus(status);
        if (goodsService.save(existGoods)==null){
            return Result.error(CodeMsg.HOME_STUDENT_GOODS_EDIT_ERROR);
        }
        return Result.success(true);
    }
    @RequestMapping(value = "/publish_wanted",method = RequestMethod.GET)
    public String publishWanted(Model model){
        return "home/student/publish_wanted";
    }

    /**
     * 求购物品发布提交
     * @param wantedGoods
     * @return
     */
    @RequestMapping(value="/publish_wanted", method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> publishWanted(WantedGoods wantedGoods){
        CodeMsg validate = ValidateEntityUtil.validate(wantedGoods);
        if (validate.getCode()!=CodeMsg.SUCCESS.getCode()){
            return Result.error(validate);
        }
        Student loginedStudent=(Student)SessionUtil.get(SessionConstant.SESSION_STUDENT_LOGIN_KEY);
        wantedGoods.setStudent(loginedStudent);
        if (wantedGoodsService.save(wantedGoods)==null){
            return Result.error(CodeMsg.HOME_STUDENT_PUBLISH_ERROR);
        }
        return Result.success(true);
    }


    /**
     * 商品编辑页面
     * @return
     */
    @RequestMapping(value = "/edit_pwd",method = RequestMethod.GET)
    public String editUserPwd()
    {
        return "home/student/edit_pwd";
    }

    /**
     * 修改学生用户密码
     * @param oldPwd
     * @param newPwd
     * @return
     */
    @RequestMapping(value = "/edit_pwd",method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> editPwd(@RequestParam(name = "oldPwd",required =true) String oldPwd,
                                   @RequestParam(name = "newPwd",required =true)String newPwd){
        Student loginedStudent=(Student)SessionUtil.get(SessionConstant.SESSION_STUDENT_LOGIN_KEY);
        if (!loginedStudent.getPassword().equals(oldPwd)){
            return Result.error(CodeMsg.HOME_STUDENT_EDITPWD_OLD_ERROR);
        }
        loginedStudent.setPassword(newPwd);
        if (studentService.save(loginedStudent)==null){
            return Result.error(CodeMsg.HOME_STUDENT_EDITINFO_ERROR);
        }
        SessionUtil.set(SessionConstant.SESSION_STUDENT_LOGIN_KEY,loginedStudent);
        return Result.success(true);
    }

    /**
     * 评论物品
     * @param comment
     * @return
     */
    @RequestMapping(value = "/comment",method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> comment(Comment comment){
        CodeMsg validate = ValidateEntityUtil.validate(comment);
        if (validate.getCode()!=CodeMsg.SUCCESS.getCode()){
            return Result.error(validate);
        }
        if (comment.getGoods()==null||comment.getGoods().getId()==null){
            return Result.error(CodeMsg.HOME_STUDENT_GOODS_NO_EXIST);
        }
        Student loginedStudent=(Student)SessionUtil.get(SessionConstant.SESSION_STUDENT_LOGIN_KEY);
        Goods find=goodsService.findById(comment.getGoods().getId());
        if (find==null){
            return Result.error(CodeMsg.HOME_STUDENT_GOODS_NO_EXIST);
        }
        comment.setStudent(loginedStudent);
        if (commentService.save(comment)==null){
            return Result.error(CodeMsg.HOME_STUDENT_COMMENT_ADD_ERROR);
        }
        return Result.success(true);
    }

    /**
     * 物品删除
     * @param id
     * @return
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> delete(@RequestParam(name = "id",required = true) Long id) {
        try {
            goodsService.delete(id);
        } catch (Exception e) {
            return  Result.error(CodeMsg.ADMIN_GOODS_DELETE_ERROR);
        }
        return Result.success(true);
    }
 }
