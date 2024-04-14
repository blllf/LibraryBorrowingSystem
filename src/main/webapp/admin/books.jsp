<%--
  Created by IntelliJ IDEA.
  User: lovinyq
  Date: 2024/4/7
  Time: 14:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>图书借阅</title>
    <script src="${pageContext.request.contextPath}/js/vue.js"></script>
    <script src="${pageContext.request.contextPath}/element-ui/lib/index.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/element-ui/lib/theme-chalk/index.css">
    <script src="${pageContext.request.contextPath}/js/axios-0.18.0.js"></script>
</head>
<body>

<div>
    <h2>图书借阅</h2>
</div>

<div id="bookBorrow">

    <%--下架图书对话框--%>
        <el-dialog
                title="提示"
                :visible.sync="takenOffBooksVisible"
                width="30%">
            <span style="font-size: 15">共 {{countNum}} 本图书被下架成功</span>
            <span slot="footer" class="dialog-footer">
            <el-button type="primary" @click="takenOffBooksVisible = false">完成</el-button>
            </span>
        </el-dialog>

    <%--借阅对话窗--%>
        <el-dialog
                title="图书信息"
                :visible.sync="borrowVisible"
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
                    <el-button @click="borrowVisible = false">关闭</el-button>
                </el-form-item>
            </el-form>
        </el-dialog>

    <%--新增对话框--%>
        <el-dialog
                title="图书信息"
                :visible.sync="dialogVisible"
                width="35%"
                >

            <el-form ref="form" :model="book" label-width="80px">
                <div style="display: flex; justify-content: space-between;">
                   <el-form-item label="图书名称" >
                        <el-input  v-model="book.name"></el-input>
                    </el-form-item>
                    <el-form-item label="标准ISBN">
                        <el-input v-model="book.isbn"></el-input>
                    </el-form-item>
                </div>

                <div style="display: flex; justify-content: space-between;">
                    <el-form-item label="出版社">
                        <el-input v-model="book.press"></el-input>
                    </el-form-item>
                    <el-form-item label="作者">
                        <el-input v-model="book.author"></el-input>
                    </el-form-item>
                </div>

                <div style="display: flex; justify-content: space-between;">
                    <el-form-item label="书籍页数">
                        <el-input v-model="book.pagination"></el-input>
                    </el-form-item>
                    <el-form-item label="书籍价格">
                        <el-input v-model="book.price"></el-input>
                    </el-form-item>
                </div>

                    <el-form-item label="上架状态">
                        <el-switch v-model="book.status"
                                   active-value="0"
                                   inactive-value="1"></el-switch>
                    </el-form-item>


                <el-form-item>
                    <el-button type="primary" @click="addSubmit">添加</el-button>
                    <el-button  @click="dialogVisible = false">取消</el-button>
                </el-form-item>
            </el-form>

        </el-dialog>


    <%--修改对话窗--%>
        <el-dialog
                title="编辑图书信息"
                :visible.sync="updateVisible"
                width="35%"
        >
            <el-form ref="form" :model="book" label-width="80px">
                <div style="display: flex; justify-content: space-between;">
                    <el-form-item label="图书名称" >
                        <el-input  v-model="book.name"></el-input>
                    </el-form-item>
                    <el-form-item label="标准ISBN">
                        <el-input v-model="book.isbn"></el-input>
                    </el-form-item>
                </div>
                <div style="display: flex; justify-content: space-between;">
                    <el-form-item label="出版社">
                        <el-input v-model="book.press"></el-input>
                    </el-form-item>
                    <el-form-item label="作者">
                        <el-input v-model="book.author"></el-input>
                    </el-form-item>
                </div>
                <div style="display: flex; justify-content: space-between;">
                    <el-form-item label="书籍页数">
                        <el-input v-model="book.pagination"></el-input>
                    </el-form-item>
                    <el-form-item label="书籍价格">
                        <el-input v-model="book.price"></el-input>
                    </el-form-item>
                </div>
                <el-form-item label="借阅状态">
                    <el-switch v-model="book.status"
                               active-value="1"
                               inactive-value="0"></el-switch>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" @click="saveBook">保存</el-button>
                    <el-button  @click="updateVisible = false">取消</el-button>
                </el-form-item>
            </el-form>
        </el-dialog>


    <%--搜索表单--%>
    <el-form :inline="true" :model="formInline" class="demo-form-inline">

        <%--按钮--%>
            <%--<div v-if="userSessionName === 'bllf' "> 欢迎管理员！</div>
            <div v-else>普通用户，欢迎你！</div>--%>
        <%--此按钮只有管理才能使用--%>
        <el-form-item>
            <el-button type="primary" @click="dialogVisible = true " v-if="userSessionName === '白龙飞' ">新增</el-button>
        </el-form-item>
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
            <el-button type="warning" v-if="userSessionName === '白龙飞'" @click="takenOffBook">下架图书</el-button>
        </el-form-item>

    </el-form>

        <%--表格--%>
        <template>
            <el-table
                    ref="multipleTable"
                    :data="tableData"
                    style="width: 100%"
                    tooltip-effect="dark"
                    :row-class-name="tableRowClassName"
                    @selection-change="handleSelectionChange">
                <el-table-column
                        type="index"
                        width="50">
                </el-table-column>
                <el-table-column
                        type="selection"
                        width="55">
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
                        width="150">
                </el-table-column>
                <el-table-column
                        prop="borrowTime"
                        label="借阅时间"
                        align="center"
                        width="150">
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
                        <div style="display: flex; justify-content: center;">
                            <el-button type="primary" :disabled="isButtonDisabled(scope.row.status)" @click="borrowed(scope.row)">借阅</el-button>
                            <el-button type="danger" @click="edit(scope.row)" v-if="userSessionName === '白龙飞' ">编辑</el-button>
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
                :page-sizes="[8, 10, 15, 20]"
                :page-size="100"
                layout="total, sizes, prev, pager, next, jumper"
                :total=total>
        </el-pagination>




</div>





<script>


   /* import th from "../element-ui/src/locale/lang/th";*/

    new Vue({

        el:"#bookBorrow",

        mounted(){

            this.selectBooksAll();

            this.userSessionName = '${user_session.name}';

        },

        methods: {

            countN(){

                this.countNum = this.selectedIds.length;
            },

            //下架图书
            takenOffBook(){

                console.log(this.multipleSelection);

                //弹出确认对话框
                this.$confirm('此操作将删除数据, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'

                }).then(() => {

                    for (let i = 0; i < this.multipleSelection.length; i++) {
                        let selectElment = this.multipleSelection[i];
                        this.selectedIds[i] = selectElment.id;
                        console.log(this.selectedIds[i]);
                    }

                    var _this = this;

                    axios({
                        method:"post",
                        url:"http://localhost:8080/ssmanno/takenOffBook",
                        data: _this.selectedIds
                    }).then(function (resp){
                        if (resp.data == "success"){

                            _this.selectBooksAll();

                            _this.countN();

                            _this.takenOffBooksVisible = true;
                            //弹出消息提示
                           /* _this.$message({
                                message: '图书已被下架',
                                type: 'success'
                            });*/

                        }else if (resp.data == "fail"){
                            this.$message.error("下架失败")
                        }


                    })

                })

            },

            handleSelectionChange(val) {
                this.multipleSelection = val;
               // console.log(this.multipleSelection)
            },


            //借阅保存按钮
            borrowSave(){

                var _this = this ;

                axios({
                    method: "post",
                    url:"http://localhost:8080/ssmanno/borrowBooks",
                    //如果 this.book 是一个 JavaScript 对象，它将会被 Axios 自动转换为 JSON 格式的数据。
                    data:_this.book
                }).then(resp => {
                    if (resp.data == "success" ){
                        //关闭窗口
                        this.borrowVisible = false;
                        //再次查询
                        this.selectBooksAll();
                        this.$message({
                            message: '借阅成功',
                            type: 'success'
                        });
                    }

                })
            },

            borrowed(row){

                //将 JavaScript 对象 row 深度复制到另一个变量 this.book 中
                //创建了 this.book 变量，其中包含了 row 对象的完整副本，而不是原始对象的引用

                this.book = JSON.parse(JSON.stringify(row));

                this.borrowVisible = true;

            },


            //保存图书信息
            saveBook(){

                var _this = this;
                axios({
                    method:"post",
                    url:"http://localhost:8080/ssmanno/updateBook",
                    data:_this.book
                }).then(resp => {
                    if (resp.data == "success"){
                        //关闭窗口
                        _this.updateVisible = false;

                        this.selectBooksAll();

                        this.$message({
                            message: '修改成功',
                            type: 'success'
                        })
                    }else if (resp.data == "fail"){

                        this.selectBooksAll();

                        _this.updateVisible = false;
                        this.$message.error("修改失败了，注意上架状态")

                    }
                })

            },

            //编辑书本只有管理员有这个权限
            edit(row){

                //回显数据
                this.book = JSON.parse(JSON.stringify(row));

                this.updateVisible = true;

            },


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

            //新增用户
            addSubmit() {

                var _this = this;
                //console.log(this.book);
                axios({
                    method: "post",
                    url: "http://localhost:8080/ssmanno/addBook",
                    data: _this.book
                }).then(resp => {
                        if (resp.data == "success" ) {

                            //关闭窗口
                            this.dialogVisible = false;
                            //再次查询
                            this.selectBooksAll();

                            this.$message({
                                message: '添加成功',
                                type: 'success'
                            });
                        }else if (resp.data == "fail"){
                            //关闭窗口
                            this.dialogVisible = false;
                            this.$message.error("添加失败了，未点击上架状态")
                        }
                })

                //this.dialogVisible = false;
            },

            //这个是查询所有且分页方法，
            selectBooksAll(){
                var _this = this;
                axios({
                    method:"post",
                    url:"http://localhost:8080/ssmanno/paginatedQueries?pageNum="+_this.currentPage+"&pageSize="+_this.pageSize
                }).then(function (resp) {
                    _this.showPagination = true ;
                    _this.tableData = resp.data.rows;
                    _this.total = resp.data.total;
                })
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

            //分页方法
            //一页展示多少个数据
            handleSizeChange(val) {

                this.pageSize = val;

                this.selectBooksAll();
              //  this.search();
            },
            //展示那一页数
            handleCurrentChange(val) {

                this.currentPage = val;

                this.selectBooksAll()

              //  this.search()
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

                countNum: 0 ,

                //被选中的id
                selectedIds: [],

                multipleSelection: [],

                //控制分页工具条的显示与隐藏,当前状态为显示
                showPagination:true,

                //初始化为session中获得的值
                userSessionName:'',

                //分页 当前页码
                currentPage: 1,
                //初始页面展示的图书数量
                pageSize:8,

                //总页数
                total:10,

                //新增书本信息
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

                takenOffBooksVisible:false,

                dialogVisible:false,

                updateVisible:false,

                borrowVisible:false,

                //搜索表单的数据
                formInline: {
                    name: '',
                    author: '',
                    press:''
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
