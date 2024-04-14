<%--
  Created by IntelliJ IDEA.
  User: lovinyq
  Date: 2024/4/4
  Time: 21:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>新书推荐</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminLTE.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination.css">
    <style>
        .el-table .warning-row {
            background: oldlace;
        }

        .el-table .success-row {
            background: #f0f9eb;
        }
    </style>
</head>


<body>
<!--数据展示头部-->

<div style="font-weight: lighter; font-style: italic" align="center">

    <h3>震撼来袭！新书推荐，让你在知识的海洋里畅游，尽享不一样的风采！</h3>
    <el-divider content-position="right">云借阅-图书馆</el-divider>
</div>




<div id="app">

    <%--借阅对话框--%>
        <el-dialog
                title="图书信息"
                :visible.sync="dialogVisible"
                width="30%"
                >
            <el-form ref="form" :model="book" label-width="80px">
                <el-form-item label="图书名称">
                    <el-input v-model="book.name"></el-input>
                </el-form-item>
                <el-form-item label="图书ISBN">
                    <el-input v-model="book.isbn"></el-input>
                </el-form-item>
                <el-form-item label="出版社">
                    <el-input v-model="book.press"></el-input>
                </el-form-item>
                <el-form-item label="图书作者">
                    <el-input v-model="book.author"></el-input>
                </el-form-item>
                <el-form-item label="借阅人">
                    <el-input v-model="book.borrower"></el-input>
                </el-form-item>
                <el-form-item label="借还时间">
                    <el-col :span="11">
                        <el-date-picker type="date" placeholder="选择日期" v-model="book.borrowTime" style="width: 100%;"></el-date-picker>
                    </el-col>
                    <el-col class="line" :span="2">-</el-col>
                    <el-col :span="11">
                        <el-date-picker type="date" placeholder="选择时间" v-model="book.returnTime" style="width: 100%;"></el-date-picker>
                    </el-col>
                </el-form-item>

                <el-form-item>
                    <el-button type="primary" @click="borrowSave">保存</el-button>
                    <el-button @click="dialogVisible = false">关闭</el-button>
                </el-form-item>
            </el-form>
        </el-dialog>

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
                    prop="name"
                    label="图书名称"
                    align="center"
                    width="180">
            </el-table-column>
            <el-table-column
                    prop="author"
                    label="图书作者"
                    align="center"
                    width="180">
            </el-table-column>
            <el-table-column
                    prop="press"
                    label="出版社"
                    align="center"
                    width="180">
            </el-table-column>
            <el-table-column
                    prop="isbn"
                    label="标准ISBN"
                    align="center"
                    width="180">
            </el-table-column>
            <el-table-column
                    prop="status"
                    label="书籍状态"
                    align="center"
                    width="180"
                    :formatter="getStatusText">
            </el-table-column>
            <el-table-column
                    prop="borrower"
                    label="借阅人"
                    align="center"
                    width="180">
            </el-table-column>
            <el-table-column
                    prop="borrowTime"
                    label="借阅时间"
                    align="center"
                    width="180">
            </el-table-column>
            <el-table-column
                    prop="returnTime"
                    label="预计归还时间"
                    align="center"
                    width="180">
            </el-table-column>
            <el-table-column
                    label="操作"
                    align="center">
                <el-row slot-scope="scope">
                    <%--scope.row通常是用于访问表格或列表中当前行的一种方式。
                    scope.row表示当前循环迭代中的行对象。--%>
                    <el-button type="primary" :disabled="isButtonDisabled(scope.row.status)"  @click="editBook(scope.row)">借阅</el-button>
                </el-row>
            </el-table-column>
        </el-table>
    </template>

</div>



<script src="${pageContext.request.contextPath}/js/vue.js"></script>
<script src="${pageContext.request.contextPath}/element-ui/lib/index.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/element-ui/lib/theme-chalk/index.css">
<script src="${pageContext.request.contextPath}/js/axios-0.18.0.js"></script>


<script>
    new Vue({
        el:"#app",

        mounted(){
            //页面加载完成后，发送异步请求

            this.selectByRecommend();

        },


        methods: {


            //推荐查询
            selectByRecommend(){
                var _this = this;
                axios({
                    method:"get",
                    url:"http://localhost:8080/ssmanno/testJson"
                }).then(function (resp) {
                    _this.tableData = resp.data.rows;

                })
            },


            tableRowClassName({row, rowIndex}) {
                if (rowIndex === 1) {
                    return 'warning-row';
                } else if (rowIndex === 3) {
                    return 'success-row';
                }
                return '';
            },

            //借阅保存方法
            borrowSave() {

                axios({
                    method: "post",
                    url:"http://localhost:8080/ssmanno/borrowBooks",
                    //如果 this.book 是一个 JavaScript 对象，它将会被 Axios 自动转换为 JSON 格式的数据。
                    data:this.book
                }).then(resp => {
                    if (resp.data == "success" ){

                        //关闭窗口
                        this.dialogVisible = false;

                        //再次查询
                        this.selectByRecommend();


                        this.$message({
                            message: '借阅成功',
                            type: 'success'
                        });
                    }else if (resp.data == "fail"){

                        //再次查询
                        this.selectByRecommend();

                        this.$message.error("借阅失败，请再次检查信息是否完整");

                    }


                })



                console.log(this.book);
            },

            //格式化书籍状态 1-->已借阅 0-->''
            getStatusText(row , column ,status){
                if (status == 1){
                    return '借阅中';
                }

                if (status == 2){
                    return '归还中';
                }

                if (status == 0){
                    return '可借阅';
                }
            },

            //修改数据
            editBook(row){

                this.book = JSON.parse(JSON.stringify(row));

                this.dialogVisible = true;

                console.log('点击的行id是: ' , row.id);
            },

            //通过对status的值的判断，来确定按钮是否要点击
            isButtonDisabled(status) {

                if (status == 1 || status == 2){
                    return true;
                }else {
                    return false;
                }

            }



        },

        data() {
            return {

                book:{
                    name:'',
                    isbn:'',
                    press:'',
                    author:'',
                    pagination:'',
                    price:'',
                    uploadTime:'',
                    status:'',
                    borrower:'',
                    borrowTime:'',
                    returnTime:''
                },

                //借阅数据对话框是否展示的标记
                dialogVisible: false,


                tableData: [{
                    name: '沉默的巡游',
                    author: '东野圭吾	',
                    press: '南海出版公司',
                    isbn:'9787544280662',
                    status: '借阅中',
                    borrower: '张三',
                    borrowTime: '2012-12-11',
                    returnTime: '2012-12-23',
                }]
            }
        }
    })
</script>

</body>
</html>
