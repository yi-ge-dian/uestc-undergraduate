package com.staging.base.controller.home;

import com.staging.base.bean.CodeMsg;
import com.staging.base.bean.PageBean;
import com.staging.base.bean.Result;
import com.staging.base.constant.SessionConstant;
import com.staging.base.entity.common.Goods;
import com.staging.base.entity.common.Student;
import com.staging.base.service.common.GoodsCategoryService;
import com.staging.base.service.common.GoodsService;
import com.staging.base.service.common.StudentService;
import com.staging.base.util.SessionUtil;
import com.staging.base.util.ValidateEntityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.jws.WebParam;

/**
 * 前台首页控制器
 */
@RequestMapping("/home/index")
@Controller
public class IndexController {
    @Autowired
    private GoodsCategoryService goodsCategoryService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private GoodsService goodsService;
    /**
     * 前台首页
     * @param model
     * @return
     */
    @RequestMapping("/index")
    public String index(Model model, PageBean<Goods> pageBean,Goods goods){
        pageBean.setPageSize(6);
        goods.setStatus(Goods.GOODS_STATUS_UP);
        goods.setRecommend(Goods.GOODS_REVIEW_PASS);
        model.addAttribute("pageBean", goodsService.findlist(pageBean, goods));
        model.addAttribute("name",goods.getName());
        return "home/index/index";
    }


    /**
     * 用户登录页面
     * @param model
     * @return
     */
    @RequestMapping(value = "/login",method = RequestMethod.GET)
    public String login(Model model){
        return "home/index/login";
    }

    /**
     * 退出登录
     * @return
     */
    @RequestMapping(value = "/loginout",method = RequestMethod.GET)
    public String logout(){
        SessionUtil.set(SessionConstant.SESSION_STUDENT_LOGIN_KEY,null);
        return "redirect:login";
        //有问题
    }
    /**
     * 检查学号是否存在
     * @param sn
     * @return
     */
    @RequestMapping(value="/check_sn",method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> checkSn(@RequestParam(name="sn", required = true) String sn){
        Student student = studentService.findBySn(sn);
        return Result.success(student == null);
    }

    /**
     * 用户注册页面
     * @param model
     * @return
     */
    @RequestMapping(value = "/signup",method = RequestMethod.GET)
    public String signup(Model model){
        return "home/index/signup";
    }

    /**
     * 用户注册表单提交
     * @param student
     * @return
     */
    @RequestMapping(value="/register",method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> register(Student student){
        CodeMsg validate = ValidateEntityUtil.validate(student);
        if(validate.getCode() != CodeMsg.SUCCESS.getCode()){
            return Result.error(validate);
        }
        //基本验证通过
        if(studentService.findBySn(student.getSn()) != null){
            return Result.error(CodeMsg.HOME_STUDENT_REGISTER_SN_EXIST);
        }
        student = studentService.save(student);
        if(student ==null){
            return Result.error(CodeMsg.HOME_STUDENT_REGISTER_ERROR);
        }

        //注册成功，放入session
        SessionUtil.set(SessionConstant.SESSION_STUDENT_LOGIN_KEY, student);
        return Result.success(true);
    }

    /**
     * 用户登录表单提交
     * @param sn
     * @param password
     * @return
     */
    @RequestMapping(value="/login",method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> login(@RequestParam(name="sn", required = true) String sn,
                                 @RequestParam(name="password", required = true) String password){
       Student student = studentService.findBySn(sn);
        //基本验证通过
       // if(student == null){
        //    return Result.error(CodeMsg.HOME_STUDENT_REGISTER_SN_EXIST);
        //}
       // student = studentService.save(student);
        if(student == null){
            return Result.error(CodeMsg.HOME_STUDENT_SN_NO_EXIST);
        }
        //表示学号存在，验证密码
        if(!student.getPassword().equals(password)){
            return Result.error(CodeMsg.HOME_STUDENT_PASSWORD_ERROR);
        }
        //验证用户状态是否被冻结
        if(student.getStatus()!=Student.STUDENT_STATUS_ENABLE){
            return Result.error(CodeMsg.HOME_STUDENT_UNABLE);
        }
        //一切都符合
        SessionUtil.set(SessionConstant.SESSION_STUDENT_LOGIN_KEY, student);
        return Result.success(true);
    }
}
