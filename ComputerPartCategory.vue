<template>
  <div class="stock-out-container">
    <el-card class="box-card">
      <template #header>
        <div class="card-header">
          <span class="title">配件出库管理</span>
          <el-button type="primary" @click="handleAdd">新增出库</el-button>
        </div>
      </template>

      <!-- 搜索条件 -->
      <div class="search-box">
        <el-input
          v-model="searchParams.computerpartName"
          placeholder="搜索配件名称..."
          style="width: 200px; margin-right: 10px"
        />
        <el-button @click="handleSearch">搜索</el-button>
        <el-button @click="handleReset">重置</el-button>
      </div>

      <!-- 列表 -->
      <el-table :data="tableData" stripe style="width: 100%; margin-top: 20px">
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="computerpartName" label="配件名称" />
        <el-table-column prop="quantity" label="出库数量" width="120" />
        <el-table-column prop="remark" label="备注" />
        <el-table-column prop="createdAt" label="创建时间" width="180">
          <template #default="{ row }">
            {{ formatDate(row.createdAt) }}
          </template>
        </el-table-column>
        <el-table-column label="操作" width="120" fixed="right">
          <template #default="{ row }">
            <el-button link type="danger" @click="handleDelete(row.id)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <el-pagination
        v-model:current-page="pagination.page"
        v-model:page-size="pagination.size"
        :page-sizes="[10, 20, 50]"
        :total="pagination.total"
        layout="total, sizes, prev, pager, next, jumper"
        style="margin-top: 20px; text-align: right"
      />
    </el-card>

    <!-- 新增/编辑对话框 -->
    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="500px">
      <el-form :model="formData" label-width="100px">
        <el-form-item label="配件名称" required>
          <el-select
            v-model="formData.medicineId"
            placeholder="请选择配件"
            @change="onMedicineChange"
          >
            <el-option
              v-for="item in medicineOptions"
              :key="item.id"
              :label="`${item.name} (库存: ${item.stock})`"
              :value="item.id"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="出库数量" required>
          <el-input-number v-model="formData.quantity" :min="1" />
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="formData.remark" type="textarea" rows="3" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleSave">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount, watch } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { stockOutApi } from '@/api/stock'
import { medicineApi } from '@/api/medicine'

const tableData = ref([])
const dialogVisible = ref(false)
const dialogTitle = ref('新增出库')
const searchParams = ref({ computerpartName: '' })
const formData = ref({ medicineId: null, quantity: 1, remark: '' })
const pagination = ref({ page: 1, size: 10, total: 0 })
const medicineOptions = ref([])

// 格式化日期
const formatDate = (dateStr) => {
  if (!dateStr) return ''
  return new Date(dateStr).toLocaleString('zh-CN')
}

// 获取列表
const fetchList = async () => {
  try {
    const response = await stockOutApi.getList({
      page: pagination.value.page,
      size: pagination.value.size
    })
    tableData.value = response.data || []
    pagination.value.total = response.total || 0
  } catch (error) {
    ElMessage.error('获取出库记录失败')
    console.error(error)
  }
}

// 获取配件列表
const fetchMedicines = async () => {
  try {
    const response = await medicineApi.getList({
      page: 1,
      size: 999
    })
    medicineOptions.value = response.data || []
  } catch (error) {
    ElMessage.error('获取配件列表失败')
    console.error(error)
  }
}

// 搜索
const handleSearch = () => {
  pagination.value.page = 1
  fetchList()
}

// 重置
const handleReset = () => {
  searchParams.value = { computerpartName: '' }
  pagination.value.page = 1
  fetchList()
}

// 新增
const handleAdd = () => {
  formData.value = { medicineId: null, quantity: 1, remark: '' }
  dialogTitle.value = '新增出库'
  dialogVisible.value = true
}

// 保存
const handleSave = async () => {
  if (!formData.value.medicineId || !formData.value.quantity) {
    ElMessage.warning('请填写必要信息')
    return
  }

  try {
    await stockOutApi.add(formData.value)
    ElMessage.success('出库成功')
    dialogVisible.value = false
    fetchList()
    // 刷新配件列表以获取最新库存
    fetchMedicines()
  } catch (error) {
    ElMessage.error('出库失败：' + error.message)
    console.error(error)
  }
}

// 删除
const handleDelete = async (id) => {
  try {
    await ElMessageBox.confirm('确定删除该出库记录吗？', '警告', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })

    await stockOutApi.delete(id)
    ElMessage.success('删除成功')
    fetchList()
    // 刷新配件列表以获取最新库存
    fetchMedicines()
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error('删除失败')
      console.error(error)
    }
  }
}

// 配件选择变化
const onMedicineChange = () => {
  // 可以在这里添加选择配件后的额外逻辑
}

// 监听分页变化
const watchPagination = watch(
  () => pagination.value.page,
  () => fetchList()
)

// 生命周期
onMounted(() => {
  fetchList()
  fetchMedicines()
})

onBeforeUnmount(() => {
  watchPagination?.()
})
</script>

<style scoped>
.stock-out-container {
  padding: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.title {
  font-size: 18px;
  font-weight: bold;
}

.search-box {
  margin-bottom: 20px;
  padding: 15px;
  background-color: #f5f7fa;
  border-radius: 4px;
}
</style>
