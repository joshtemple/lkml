connection: "aw2000_conn_bo"

include: "*.view"

include: "*.dashboard"

explore: Product {
	view_name: Product
	join: ProductSubcategory {
		type: inner
		sql_on: ${Product.ProductSubcategoryID} = ${ProductSubcategory.ProductSubcategoryID} ;;
		relationship: many_to_one
	}
	join: ProductCategory {
		type: inner
		sql_on: ${ProductSubcategory.ProductCategoryID} = ${ProductCategory.ProductCategoryID} ;;
		relationship: many_to_one
	}
	join: ProductReview {
		type: inner
		sql_on: ${Product.ProductID} = ${ProductReview.ProductID} ;;
		relationship: one_to_many
	}
	join: WorkOrder {
		type: inner
		sql_on: ${Product.ProductID} = ${WorkOrder.ProductID} ;;
		relationship: one_to_many
	}
	join: WorkOrderRouting {
		type: inner
		sql_on: ${Product.ProductID} = ${WorkOrderRouting.ProductID} ;;
		relationship: one_to_many
	}
	join: Location {
		type: inner
		sql_on: ${WorkOrderRouting.LocationID} = ${Location.LocationID} ;;
		relationship: many_to_one
	}
	join: ProductVendor {
		type: inner
		sql_on: ${Product.ProductID} = ${ProductVendor.ProductID} ;;
		relationship: one_to_many
	}
	join: Vendor {
		type: inner
		sql_on: ${ProductVendor.VendorID} = ${Vendor.VendorID} ;;
		relationship: many_to_one
	}
}

explore: ProductSubcategory {
	view_name: ProductSubcategory
	join: ProductCategory {
		type: inner
		sql_on: ${ProductSubcategory.ProductCategoryID} = ${ProductCategory.ProductCategoryID} ;;
		relationship: many_to_one
	}
}

explore: ProductCategory {
	view_name: ProductCategory
}

explore: ProductReview {
	view_name: ProductReview
}

explore: Location {
	view_name: Location
}

explore: WorkOrder {
	view_name: WorkOrder
}

explore: WorkOrderRouting {
	view_name: WorkOrderRouting
	always_filter: {
		filters: {
			field: ManufactureHrs
			value: ">2.0000"
		}
	}
	join: Location {
		type: inner
		sql_on: ${WorkOrderRouting.LocationID} = ${Location.LocationID} ;;
		relationship: many_to_one
	}
}

explore: Vendor {
	view_name: Vendor
}

explore: ProductVendor {
	view_name: ProductVendor
	join: Vendor {
		type: inner
		sql_on: ${ProductVendor.VendorID} = ${Vendor.VendorID} ;;
		relationship: many_to_one
	}
}

explore: PurchaseOrderHeader {
	view_name: PurchaseOrderHeader
	join: PurchaseOrderDetail {
		type: inner
		sql_on: ${PurchaseOrderHeader.PurchaseOrderID} = ${PurchaseOrderDetail.PurchaseOrderID} ;;
		relationship: one_to_many
	}
	join: Product {
		type: inner
		sql_on: ${PurchaseOrderDetail.ProductID} = ${Product.ProductID} ;;
		relationship: many_to_one
	}
	join: ProductSubcategory {
		type: inner
		sql_on: ${Product.ProductSubcategoryID} = ${ProductSubcategory.ProductSubcategoryID} ;;
		relationship: many_to_one
	}
	join: ProductCategory {
		type: inner
		sql_on: ${ProductSubcategory.ProductCategoryID} = ${ProductCategory.ProductCategoryID} ;;
		relationship: many_to_one
	}
	join: Employee {
		type: inner
		sql_on: ${PurchaseOrderHeader.EmployeeID} = ${Employee.EmployeeID} ;;
		relationship: many_to_one
	}
	join: Contact {
		type: inner
		sql_on: ${Employee.ContactID} = ${Contact.ContactID} ;;
		relationship: many_to_one
	}
}

explore: PurchaseOrderDetail {
	view_name: PurchaseOrderDetail
	join: Product {
		type: inner
		sql_on: ${PurchaseOrderDetail.ProductID} = ${Product.ProductID} ;;
		relationship: many_to_one
	}
	join: ProductSubcategory {
		type: inner
		sql_on: ${Product.ProductSubcategoryID} = ${ProductSubcategory.ProductSubcategoryID} ;;
		relationship: many_to_one
	}
	join: ProductCategory {
		type: inner
		sql_on: ${ProductSubcategory.ProductCategoryID} = ${ProductCategory.ProductCategoryID} ;;
		relationship: many_to_one
	}
}

explore: Employee {
	view_name: Employee
	join: Contact {
		type: inner
		sql_on: ${Employee.ContactID} = ${Contact.ContactID} ;;
		relationship: many_to_one
	}
}

explore: Contact {
	view_name: Contact
}

