package com.staging.base.dao.common;

import com.staging.base.entity.common.Goods;
import com.staging.base.entity.common.Student;
import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 物品数据库操作dao
 */
@Repository
public interface GoodsDao extends JpaRepository<Goods,Long> {
    /**
     * 根据id获取
     * @return
     */
    @Query("select g from Goods g where id =:id")
    Goods find(@Param("id")Long id);

    /**
     * 根据学生查询
     * @param student
     * @return
     */
    List<Goods> findByStudent(Student student);

    @Query(value="select * from barter_good",nativeQuery = true)
    List<Goods> findAll();

    /**
     * 根据学生id和商品id查询
     * @param id
     * @param studentID
     * @return
     */
    @Query("select g from Goods g where id =:id and g.student.id=:studentID ")
    Goods find(@Param("id")Long id,@Param("studentID")Long studentID);
    /**
     * 根据物品分类查询
     * @param cids
     * @param offset
     * @param pageSize
     * @return
     */
    @Query(value = "select * from barter_goods where goods_category_id IN :cids and `status`=1 and `recommend`=2 ORDER BY create_time desc, flag desc ,recommend desc limit :offset,:pageSize",nativeQuery = true)
    List<Goods> findList(@Param("cids")List<Long> cids,@Param("offset")Integer offset,@Param("pageSize")Integer pageSize);

    /**
     * 根据分类搜索的总条数
     * @param cids
     * @return
     */
    @Query(value = "select count(*) from barter_goods where goods_category_id in :cids  and `status`=1 and `recommend`=2",nativeQuery = true)
    Long getTotalCount(@Param("cids")List<Long> cids);

    /**
     * 根据物品名称模糊搜索
     * @param name
     * @return
     */
    @Query(value = "select * from  barter_goods  where  name like %:name%",nativeQuery = true)
    List<Goods> findListByName(@Param("name") String name);
}
