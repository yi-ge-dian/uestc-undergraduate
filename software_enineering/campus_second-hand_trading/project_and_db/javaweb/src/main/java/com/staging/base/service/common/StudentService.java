package com.staging.base.service.common;
/**
 * 学生信息操作service
 */

import com.staging.base.bean.PageBean;
import com.staging.base.dao.common.StudentDao;
import com.staging.base.entity.common.Goods;
import com.staging.base.entity.common.GoodsCategory;
import com.staging.base.entity.common.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudentService {
    @Autowired
    private StudentDao studentDao;

    /**
     * 根据学号查询
     * @param sn
     * @return
     */
    public Student findBySn(String sn){
        return studentDao.findBySn(sn);
    }

    /**
     * 根据id查找
     * @param id
     * @return
     */
    public Student findById(Long id){
        return studentDao.find(id);
    }
    /**
     * 学生修改/编辑，当传入id为编辑，若id为空则为添加
     * @param student
     * @return
     */
    public Student save(Student student){
        return studentDao.save(student);
    }

    /**
     * 搜索学生列表
     * @param pageBean
     * @param student
     * @return
     */
    public PageBean<Student> findlist(PageBean<Student> pageBean,Student student){
        ExampleMatcher exampleMatcher = ExampleMatcher.matching();
        exampleMatcher = exampleMatcher.withMatcher("sn", ExampleMatcher.GenericPropertyMatchers.contains());
        exampleMatcher = exampleMatcher.withIgnorePaths("status");
        Example<Student> example = Example.of(student, exampleMatcher);
        Sort sort = Sort.by(Sort.Direction.DESC,"createTime");
        PageRequest pageable = PageRequest.of(pageBean.getCurrentPage()-1, pageBean.getPageSize(), sort);
        Page<Student> findAll= studentDao.findAll(example, pageable);
        pageBean.setContent(findAll.getContent());
        pageBean.setTotal(findAll.getTotalElements());
        pageBean.setTotalPage(findAll.getTotalPages());
        return pageBean;
    }

    /**
     * 根据id删除
     * @param id
     */
    public void delete(Long id){
        studentDao.deleteById(id);
    }
}
