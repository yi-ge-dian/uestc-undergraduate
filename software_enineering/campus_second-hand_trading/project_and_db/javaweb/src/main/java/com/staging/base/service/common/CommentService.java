package com.staging.base.service.common;
/**
 * 评论管理service
 */

import com.staging.base.bean.PageBean;
import com.staging.base.dao.common.CommentDao;
import com.staging.base.dao.common.GoodsDao;
import com.staging.base.entity.common.Comment;
import com.staging.base.entity.common.Goods;
import com.staging.base.entity.common.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.rmi.server.UID;
import java.util.List;

@Service
public class CommentService {

    @Autowired
    private CommentDao commentDao;

    /**
     * 评论添加/编辑，当id不为空时，则编辑
     * @param comment
     * @return
     */
    public Comment save(Comment comment){
        return commentDao.save(comment);
    }


    /**
     * 根据id查询
     * @param id
     * @return
     */
    public Comment findById(Long id){
        return commentDao.find(id);
    }

    /**
     * 评论信息删除
     * @param id
     */
    public void delete(Long id){
        commentDao.deleteById(id);
    }

    /**
     * 根据学生查找商品
     * @param student
     * @return
     */
    public List<Comment> findByStudent(Student student){
        return commentDao.findByStudent(student);
    }

    /**
     * 根据物品查找
     * @param goods
     * @return
     */
    public List<Comment> findByGoods(Goods goods){
        return commentDao.findByGoods(goods);
    }

    /**
     * 根据学生id和评论id查询
     * @param id
     * @param studentID
     * @return
     */
    public Comment find(Long id,Long studentID){
        return commentDao.find(id,studentID);
    }

    /**
     * 多条件搜索物品评论
     * @param pageBean
     * @param comment
     * @param goodsList
     * @return
     */
    public PageBean<Comment> findlist(PageBean<Comment> pageBean,Comment comment,List<Goods> goodsList){

        Specification<Comment> specification=new Specification<Comment>() {
            private static final long serialVersionUID =1L;
            @Override
            public Predicate toPredicate(Root<Comment> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                Predicate predicate = criteriaBuilder.like(root.get("content"), "%"+(comment.getContent()==null?"":comment.getContent()+"%"));
                if (comment.getStudent()!=null&&comment.getStudent().getId()!=null){
                    Predicate equal1=criteriaBuilder.equal(root.get("student"),comment.getStudent().getId());
                    predicate=criteriaBuilder.and(predicate,equal1);
                }
                if (goodsList!=null &&goodsList.size()>0){
                    CriteriaBuilder.In<Object> in = criteriaBuilder.in(root.get("goods"));
                    in.value(goodsList);
                    predicate=criteriaBuilder.and(predicate,in);
                }
                return predicate;
            }
        };
        Sort sort = Sort.by(Sort.Direction.DESC,"createTime");
        PageRequest pageable = PageRequest.of(pageBean.getCurrentPage()-1, pageBean.getPageSize(), sort);
        Page<Comment> findAll= commentDao.findAll(specification, pageable);
        pageBean.setContent(findAll.getContent());
        pageBean.setTotal(findAll.getTotalElements());
        pageBean.setTotalPage(findAll.getTotalPages());
        return pageBean;
    }
}
