<%--
  Created by IntelliJ IDEA.
  User: lovinyq
  Date: 2024/4/11
  Time: 12:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>借阅记录</title>
    <script src="${pageContext.request.contextPath}/js/vue.js"></script>
    <script src="${pageContext.request.contextPath}/element-ui/lib/index.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/element-ui/lib/theme-chalk/index.css">
    <script src="${pageContext.request.contextPath}/js/axios-0.18.0.js"></script>
</head>

<style>
    .remandtime-column .cell {
        color: red; /* 设置为你想要的颜色 */
    }
</style>


<body>



<div>
    <h2>借阅记录</h2>
</div>

<div id="record">

    <%--删除对话框--%>
    <el-dialog
            title="删除提示"
            :visible.sync="deleteVisible"
            width="30%">
        <span></span>
        <span slot="footer" class="dialog-footer">
    <el-button @click="deleteVisible = false">取 消</el-button>
    <el-button type="primary" @click="deleteVisible = false">确 定</el-button>
        </span>
    </el-dialog>


    <%--搜索表单--%>
    <el-form :inline="true" :model="formInline" class="demo-form-inline">

        <el-form-item label="图书名称">
            <el-input v-model="formInline.bookname" placeholder="图书名称"></el-input>
        </el-form-item>
        <el-form-item label="借阅人">
            <el-input v-model="formInline.borrower" placeholder="借阅人"></el-input>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" icon="el-icon-search" @click="searchByborrower">搜索</el-button>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" @click="selectRecordAll">查询所用</el-button>
        </el-form-item>
    </el-form>

    <%--表格--%>
    <template>
        <el-table
                :data="tableData"
                style="width: 100%"
                :row-class-name="tableRowClassName">
            <el-table-column
                    type="index"
                    width="50">
            </el-table-column>
            <el-table-column
                    prop="bookname"
                    label="图书名称"
                    align="center"
                    width="250">
            </el-table-column>
            <el-table-column
                    prop="bookisbn"
                    label="标准ISBN"
                    align="center"
                    width="250">
            </el-table-column>
            <el-table-column
                    prop="borrower"
                    label="借阅人"
                    align="center"
                    width="180">
            </el-table-column>
            <el-table-column
                    prop="borrowtime"
                    label="借阅时间"
                    align="center"
                    width="180">
            </el-table-column>
            <el-table-column
                    prop="remandtime"
                    label="归还时间"
                    align="center"
                    width="300"
                    class-name="remandtime-column">
            </el-table-column>
            <el-table-column
                    label="操作"
                    align="center"
                    width="180"
                    v-if="userSessionName === '白龙飞'" >
                <el-row slot-scope="scope">
                    <el-button type="danger" @click="deleteById(scope.row)" icon="el-icon-delete" circle></el-button>
                </el-row>
            </el-table-column>
        </el-table>
    </template>



</div>



<script>
    new Vue({

        el: "#record",

        mounted(){

            this.userSessionName = '${user_session.name}';

            this.selectRecordAll();

        },

        methods:{

            deleteById(row){

                var _this = this ;
                _this.book.id = row.id;

                _this.$confirm('此操作将删除该数据, 是否继续?', '提示', {
                    confirmButtonText: '继续',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    axios({
                        method:"get",
                        url:"http://localhost:8080/ssmanno/deleteById?id="+ _this.book.id

                    }).then(function (resp){
                        if (resp.data === "success"){

                            _this.selectRecordAll();

                            _this.$message({
                                message: '删除成功',
                                type: 'success'
                            });
                        }
                    })
                })
            },

            searchByborrower(){

                var _this = this;
                axios({
                    method: "post",
                    url: "http://localhost:8080/ssmanno/selectByBorrower",
                    data:_this.formInline
                }).then(function (resp) {
                    _this.tableData = resp.data;
                })

            },

            selectRecordAll(){
                var _this = this;
                axios({
                    method:"post",
                    url:"http://localhost:8080/ssmanno/selectRecord?pageNum="+_this.pageNum + "&pageSize=" + _this.pageSize,
                }).then(function (resp){
                    _this.tableData = resp.data.rows;
                })
            }

        },

        data(){
            return{

                //初始化为session中获得的值
                userSessionName:'',

                deleteVisible:false,

                pageNum: 1,
                pageSize: 1000,

                //搜索表单的数据
                formInline: {
                    bookname: '',
                    borrower: ''
                },

                book:{
                    id:'',
                    bookname: '',
                    bookisbn: '',
                    borrower: '',
                    borrowtime: '',
                    remandtime: ''
                },

                tableData: [{
                    bookname: '沉默的巡游',
                    bookisbn:'9787544280662',
                    borrower: '张三',
                    borrowtime: '2012-12-11',
                    remandtime: '2012-12-23',
                }]

            }
        }
    })
</script>

</body>
</html>
