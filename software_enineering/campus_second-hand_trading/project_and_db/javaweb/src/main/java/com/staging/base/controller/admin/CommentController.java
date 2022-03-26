package com.staging.base.controller.admin;

import com.staging.base.bean.CodeMsg;
import com.staging.base.bean.PageBean;
import com.staging.base.bean.Result;
import com.staging.base.entity.common.Comment;
import com.staging.base.entity.common.Goods;
import com.staging.base.entity.common.Student;
import com.staging.base.service.common.CommentService;
import com.staging.base.service.common.GoodsCategoryService;
import com.staging.base.service.common.GoodsService;
import com.staging.base.service.common.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 物品评论管理控制器
 */

@RequestMapping("/admin/comment")
@Controller
public class CommentController {

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private CommentService commentService;
    /**
    /**
     * 物品管理列表页面
     *
     * @param comment
     * @param pageBean
     * @param model
     * @return
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(Comment comment, PageBean<Comment> pageBean, Model model) {
       if (comment.getStudent()!=null &&comment.getStudent().getSn()!=null){
           Student student = studentService.findBySn(comment.getStudent().getSn());
           if (student !=null){
               comment.setStudent(student);
           }
       }
       List<Goods> goodsList=null;
        if (comment.getGoods()!=null&&comment.getGoods().getName()!=null){
            goodsList = goodsService.findListByName(comment.getGoods().getName());
        }

        model.addAttribute("title", "物品评论列表");
        model.addAttribute("content", comment.getContent());
        model.addAttribute("name", comment.getGoods()==null?null:comment.getGoods().getName());
        model.addAttribute("sn", comment.getGoods()==null?null:comment.getStudent().getSn());
        model.addAttribute("pageBean", commentService.findlist(pageBean, comment,goodsList));
        /*model.addAttribute("pageBean", commentService.findlist(pageBean, comment));*/
        return "admin/comment/list";
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
            commentService.delete(id);
        } catch (Exception e) {
            return  Result.error(CodeMsg.ADMIN_COMMENT_DELETE_ERROR);
        }
        return Result.success(true);
    }
}
