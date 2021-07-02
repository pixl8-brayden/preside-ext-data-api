/**
 * @feature        dataApiLog
 * @versioned      false
 * @nolabel        true
 * @noDateModified true
 */
component {
	property name="id"             type="numeric" dbtype="int"     generator="increment";
	property name="object_name"    type="string"  dbtype="varchar" maxlength=100 required=true  indexes="object_name";
	property name="namespace"      type="string"  dbtype="varchar" maxlength=50  required=false indexes="namespace";
	property name="record_id"      type="string"  dbtype="varchar" maxlength=100 required=true  indexes="record_id";
	property name="operation"      type="string"  dbtype="varchar" maxlength=10  required=true  indexes="operation"   enum="dataApiQueueOperation";
	property name="serialize_data" type="string"  dbtype="longtext"              required=false;
}