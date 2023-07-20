
/* todo list:
 1. 避免使用者因網路延遲等關係點按鈕太多次，導致資料重複傳送：傳送資料後把按鈕鎖起來，等待status接收到再解鎖按鈕。
 2. To execute an action when UITabBarItem is pressed : editProfile 儲存之後要refresh Profile
 3. encode postParameter.(&data={等於之後都要encode!)
    =>addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    =>json encode
 4. 在 numberOfRows 那裡要檢查資料讀進來了沒, 如果還沒, 應該回傳 0,然後在網路回傳那邊, 如果有回傳了, 再 tableView.reloadData
 將json封裝成一個class、將資料來源封裝、encodeable、class（發送http請求、接收http請求）

 */

/* completed:
 完成updateUserData的錯誤處理 2018/5/3
 
 */
