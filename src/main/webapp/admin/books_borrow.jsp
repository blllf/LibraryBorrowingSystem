<%--
  Created by IntelliJ IDEA.
  User: lovinyq
  Date: 2024/4/9
  Time: 21:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>当前借阅</title>
    <script src="${pageContext.request.contextPath}/js/vue.js"></script>
    <script src="${pageContext.request.contextPath}/element-ui/lib/index.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/element-ui/lib/theme-chalk/index.css">
    <script src="${pageContext.request.contextPath}/js/axios-0.18.0.js"></script>
</head>
<body>

<div>
    <h2>当前借阅</h2>
</div>

<div id = "booksBorrow">
    <%--搜索表单--%>
    <el-form :inline="true" :model="formInline" class="demo-form-inline">

        <el-form-item label="图书名称">
            <el-input v-model="formInline.name" placeholder="图书名称"></el-input>
        </el-form-item>
        <el-form-item label="图书作者">
            <el-input v-model="formInline.author" placeholder="图书作者"></el-input>
        </el-form-item>
        <el-form-item label="出版社">
            <el-input v-model="formInline.press" placeholder="出版社"></el-input>
        </el-form-item>

        <el-form-item>
            <el-button type="primary" icon="el-icon-search" @click="search">搜索</el-button>
        </el-form-item>

        <el-form-item>
            <el-button type="primary" @click="selectBooksAll">查询所用</el-button>
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
                    width="150"
                    :formatter="getStatusText">
            </el-table-column>
            <el-table-column
                    prop="borrower"
                    label="借阅人"
                    align="center"
                    width="150">
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
                    align="center"
                    width="200">
                <el-row slot-scope="scope">
                    <%--scope.row通常是用于访问表格或列表中当前行的一种方式。
                    scope.row表示当前循环迭代中的行对象。--%>
                    <div style="display: flex; justify-content: center;">
                        <el-button type="success" :disabled="isButtonDisabled(scope.row.status)" @click="returnBook(scope.row)" >归还</el-button>
                        <el-button type="warning"  @click="confirmTheReturn(scope.row)" v-if="userSessionName === '白龙飞' ">归还确认</el-button>
                    </div>
                </el-row>
            </el-table-column>
        </el-table>
    </template>


        <%--分页工具条--%>
        <el-pagination
                v-if="showPagination"
                @size-change="handleSizeChange"
                @current-change="handleCurrentChange"
                :current-page="currentPage"
                :page-sizes="[5, 10, 15, 20]"
                :page-size="100"
                layout="total, sizes, prev, pager, next, jumper"
                :total=total>
        </el-pagination>

        <%--归还图书提示框--%>
        <el-dialog
                title="提示"
                :visible.sync="dialogVisible"
                width="20%">

            <span>确定归还图书？</span>
            <span slot="footer" class="dialog-footer">
            <el-button @click="dialogVisible = false">取 消</el-button>
            <el-button type="primary" @click="ok">确 定</el-button>
            </span>
        </el-dialog>

    <%--确定归还提示框--%>
        <el-dialog
                :visible.sync="centerDialogVisible"
                width="25%"
                center>
            <span>还书确认中，请到621行政中心归还课本！</span>
            <span slot="footer" class="dialog-footer">
            <el-button @click="centerDialogVisible = false">取 消</el-button>
            <el-button type="primary" @click="returnTheBook">确 定</el-button>
            </span>
        </el-dialog>

        <%--管理员的操作--%>
        <%--确认归还图书提示框--%>
        <el-dialog
                title="提示"
                :visible.sync="confirmReturn"
                width="20%">

            <span>确定图书已归还？</span>
            <span slot="footer" class="dialog-footer">
            <el-button @click="confirmReturn = false">取 消</el-button>
            <el-button type="primary" @click="admin">确 定</el-button>
            </span>
        </el-dialog>

        <el-dialog
                :visible.sync="adminConfirmReturn"
                width="25%"
                center>
            <span>确认成功！</span>
            <span slot="footer" class="dialog-footer">
            <el-button @click="adminConfirmReturn = false">取 消</el-button>
            <el-button type="primary" @click="adminReturn">确 定</el-button>
            </span>
        </el-dialog>


</div>



<script>

    new Vue({

        el:"#booksBorrow" ,

        mounted(){

           this.selectBooksAll();

            this.userSessionName = '${user_session.name}';
        },


        methods:{

            //搜索
            search(){
                var _this = this;
                axios({
                    method:"post",
                    url:"http://localhost:8080/ssmanno/selectByCondition",
                    data:_this.formInline
                }).then(function (resp) {
                    _this.showPagination = false; // 切换显示状态
                    _this.tableData = resp.data;
                })
                console.log(this.formInline);
            },

            //管理员 确认归还
            confirmTheReturn(row){


                this.confirmReturn = true;

                this.book = JSON.parse(JSON.stringify(row));

            },

            admin(){
                this.confirmReturn = false;

                this.adminConfirmReturn = true;
            },

            //管理员执行归还操作逻辑
            adminReturn(){
                var _this = this;

                axios({
                    method:"post",
                    url:"http://localhost:8080/ssmanno/adminReturn",
                    data:_this.book
                }).then(resp =>{
                    if (resp = 'success'){

                        this.selectBooksAll();

                        this.adminConfirmReturn = false;

                        this.$message({
                            message: '归还成功',
                            type: 'success'
                        });
                    }
                })



            },


            //当status=2时候，禁止点击按钮
            isButtonDisabled(status){

                if (status == 2){
                    return true;
                }else {
                    return false;
                }
            },

            //归回课本，实则是把status该为2
            returnTheBook(){
                var _this = this;

                axios({
                    method: "post",
                    url: "http://localhost:8080/ssmanno/returnTheBook",
                    data:_this.book
                }).then(resp => {
                    if (resp = 'success'){

                        _this.centerDialogVisible = false;

                        this.selectBooksAll();

                        this.$message({
                            message: '正在归还中',
                            type: 'warning'
                        });
                    }
                })


            },


            ok(){

                this.dialogVisible = false;

                this.centerDialogVisible = true;
            },

            //归还图书
            returnBook(row){

                this.dialogVisible = true;

                //alert(row.id);
                this.book = JSON.parse(JSON.stringify(row));
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

            selectBooksAll(){
                var _this = this;
                axios({
                    method:"post",
                    url:"http://localhost:8080/ssmanno/selectByStatus?pageNum="+_this.currentPage+"&pageSize="+_this.pageSize
                }).then(function (resp) {
                    _this.showPagination = true;
                    _this.tableData = resp.data.rows;
                    _this.total = resp.data.total;
                })
            },

            handleSizeChange(val) {

                this.pageSize = val;

                this.selectBooksAll();
            },

            //展示那一页数
            handleCurrentChange(val) {

                this.currentPage = val;

                this.selectBooksAll();

            }
        },


        data(){
            return{

                //控制分页工具条的显示与隐藏,当前状态为显示
                showPagination:true,

                //管理员
                userSessionName:'',

                adminConfirmReturn:false,

                confirmReturn: false,

                centerDialogVisible: false,

                dialogVisible: false,

                //搜索表单的数据
                formInline: {
                    name: '',
                    author: '',
                    press:''
                },

                currentPage:1,

                pageSize:5,

                total:0,



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
