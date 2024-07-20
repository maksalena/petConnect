//
//  KeyChainStorage.swift
//  PetConnect
//
//  Created by SHREDDING on 18.08.2023.
//

import Foundation
import KeychainSwift


/// Service to handle keyChain storage (key - value)
protocol KeyChainStorageProtocol{
    
    // MARK: - AccessTokens
    func saveAccessToken(token:String)
    func saveRefreshToken(token:String)
    func saveClinicAccessToken(token:String?)
    
    func getAccessToken()->String?
    func getRefreshToken()->String?
    func getClinicAccessToken() -> String?
    
    func getAccessTokenTimeSaved()->Date?
    func getRefreshTokenTimeSaved()->Date?
    func getClinicAccessTokenTimeSaved() -> Date?
    
    func deleteAccessToken()
    func deleteRefreshToken()
    func deleteClinicAccessToken()
    
    func isAccessTokenAvailable() -> Bool
    func isClinicAccessTokenAvailable() -> Bool
    func isRefreshTokenAvailable() -> Bool
    
    // MARK: - APNS Tokens
    func setFirebaseToken(token:String)
    func setDeviceId(deviceId:String)
    
    func getFirebaseToken() ->String
    func getDeviceId() ->String
    
    // MARK: - Profile
    
    func setEmail(email:String)
    func setUsername(username:String)
    
    func setFirstName(firstName:String)
    func setSecondName(secondName:String)
    func setMiddleName(middleName:String)
    
    func setId(id:String)
    func setCreatedAt(createdAt:String)
    func setUpdatedAt(updatedAt:String)
    func setUserPhoto(image:Data)
    func setPhone(phone:String)
    func setIsClinicAccount(_ hasClinicAccount:Bool)
    
    func getEmail() -> String?
    func getUsername() -> String?
    func getFirstName() -> String?
    func getSecondName() -> String?
    func getMiddleName() -> String?
    func getId() -> String?
    func getrCeatedAt() -> String?
    func getUpdatedAt() -> String?
    func getUserPhoto() -> Data?
    func getPhone() -> String?
    func getIsClinicAccount() -> Bool?
    
    func deleteEmail()
    func deleteUsername()
    func deleteId()
    func deleteCreatedAt()
    func deleteUpdatedAt()
    func deleteUserPhoto()
    func deletePhone()
    func deleteIsClinicAccount()
    
    
    func deleteAll()
    
}

open class KeyChainStorage:KeyChainStorageProtocol{

    private let keychain = KeychainSwift()
    
    private enum TokensKeys{
        static let accessTokenKey: String = "accessToken"
        static let accessTokenTimeSavedKey: String = "accessTokenTime"
        
        static let clinicAccessTokenKey: String = "clinicAccessToken"
        static let clinicAccessTokenTimeSavedKey: String = "clinicAccessTokenTime"
        
        static let refreshTokenKey: String = "refreshToken"
        static let refreshokenTimeSavedKey: String = "refreshTokenTime"
    }
    
    private enum APNSKeys{
        static let deviceId:String = "deviceId"
        static let firebaseToken = "firebaseToken"
    }
    
    private enum ProfileKeys{
        static let email: String = "userEmail"
        static let username: String = "userUsername"
        
        static let firstName: String = "userFirstName"
        static let secondName: String = "userSecondName"
        static let middleName: String = "userMiddleName"
        
        static let id: String = "userId"
        static let createdAt: String = "userCreatedAt"
        static let updatedAt: String = "userUpdatedAt"
        
        static let userPhoto: String = "userPhoto"
        
        static let userPhone: String = "userPhone"
        static let hasClinicAccount: String = "hasClinicAccount"
    }
    
    
    let dateFormatter = DateFormatter()
    let dateFormat = "MM-dd-yyyy HH:mm"
    
    init(){
        dateFormatter.dateFormat = dateFormat
    }
    
    // MARK: - AccessTokens
    func saveAccessToken(token: String) {
        keychain.set(token, forKey: TokensKeys.accessTokenKey)
        keychain.set(dateFormatter.string(from: Date.now), forKey: TokensKeys.accessTokenTimeSavedKey)
    }
    
    func saveRefreshToken(token: String) {
        keychain.set(token, forKey: TokensKeys.refreshTokenKey)
        keychain.set(dateFormatter.string(from: Date.now), forKey: TokensKeys.refreshokenTimeSavedKey)
    }
    
    func saveClinicAccessToken(token:String?){
        guard let token = token else { return }
        keychain.set(token, forKey: TokensKeys.clinicAccessTokenKey)
        keychain.set(dateFormatter.string(from: Date.now), forKey: TokensKeys.clinicAccessTokenTimeSavedKey)
    }
    
    func getAccessToken() -> String? {
        let accessToken = keychain.get(TokensKeys.accessTokenKey)
        return accessToken
    }
    
    func getRefreshToken() -> String? {
        let refreshToken = keychain.get(TokensKeys.refreshTokenKey)
        return refreshToken
    }
    
    func getClinicAccessToken() -> String?{
        keychain.get(TokensKeys.clinicAccessTokenKey)
    }
    
    func getAccessTokenTimeSaved()->Date?{
        let dateString = keychain.get(TokensKeys.accessTokenTimeSavedKey)
        let date = dateFormatter.date(from: dateString ?? "")
        return date
    }
    
    func getRefreshTokenTimeSaved()->Date?{
        let dateString = keychain.get(TokensKeys.refreshokenTimeSavedKey)
        let date = dateFormatter.date(from: dateString ?? "")
        return date
    }
    
    func getClinicAccessTokenTimeSaved() -> Date?{
        let dateString = keychain.get(TokensKeys.clinicAccessTokenTimeSavedKey)
        let date = dateFormatter.date(from: dateString ?? "")
        return date
    }
    
    func deleteAccessToken(){
        keychain.delete(TokensKeys.accessTokenKey)
        keychain.delete(TokensKeys.accessTokenTimeSavedKey)
    }
    
    func deleteRefreshToken(){
        keychain.delete(TokensKeys.refreshTokenKey)
        keychain.delete(TokensKeys.refreshokenTimeSavedKey)
    }
    
    func deleteClinicAccessToken(){
        keychain.delete(TokensKeys.clinicAccessTokenKey)
        keychain.delete(TokensKeys.clinicAccessTokenTimeSavedKey)
    }
    
    func isAccessTokenAvailable() -> Bool {
        
        if let accessTokenTimeSaved = self.getAccessTokenTimeSaved(){
            let tokenExpired = Calendar.current.date(byAdding: DateComponents(hour: 23, minute: 50), to: accessTokenTimeSaved)!
            
            //print(tokenExpired, Date.now, separator: " - ")
            if tokenExpired > Date.now && self.isClinicAccessTokenAvailable(){
                return true
            }
        }
        
        return false
    }
    
    func isRefreshTokenAvailable() -> Bool {
        
        if let refreshTokenTimeSaved = self.getRefreshTokenTimeSaved(){
            let tokenExpired = Calendar.current.date(byAdding: DateComponents(day: 6, hour: 23, minute: 50), to: refreshTokenTimeSaved)!
            if tokenExpired > Date.now{
                return true
            }
        }
        
        return false
    }
    
    func isClinicAccessTokenAvailable() -> Bool{
        if let accessTokenTimeSaved = self.getClinicAccessTokenTimeSaved(){
            let tokenExpired = Calendar.current.date(byAdding: DateComponents(hour: 23, minute: 50), to: accessTokenTimeSaved)!
            
            if tokenExpired > Date.now {
                return true
            }
        }
        
        return false
    }
    
    func setFirebaseToken(token:String){
        keychain.set(token, forKey: APNSKeys.firebaseToken)
    }
    
    func setDeviceId(deviceId:String){
        keychain.set(deviceId, forKey: APNSKeys.deviceId)
    }
    
    func getFirebaseToken() ->String{
        if let token = keychain.get(APNSKeys.firebaseToken){
            return token
        }
        return ""
    }
    
    func getDeviceId() ->String{
        if let deviceId = keychain.get(APNSKeys.deviceId){
            return deviceId
        }
        return ""
    }
    
    // MARK: - Set Personal Info
    func setEmail(email:String){
        keychain.set(email, forKey: ProfileKeys.email)
    }
    
    func setUsername(username:String){
        keychain.set(username, forKey: ProfileKeys.username)
    }
    
    func setFirstName(firstName:String){
        keychain.set(firstName, forKey: ProfileKeys.firstName)
    }
    
    func setSecondName(secondName:String){
        keychain.set(secondName, forKey: ProfileKeys.secondName)
    }
    
    func setMiddleName(middleName:String){
        keychain.set(middleName, forKey: ProfileKeys.middleName)
    }
    
    func setId(id:String){
        keychain.set(id, forKey: ProfileKeys.id)
    }
    
    func setCreatedAt(createdAt:String){
        keychain.set(createdAt, forKey: ProfileKeys.createdAt)
    }
    
    func setUpdatedAt(updatedAt:String){
        keychain.set(updatedAt, forKey: ProfileKeys.updatedAt)
    }
    
    func setUserPhoto(image:Data){
        keychain.set(image, forKey: ProfileKeys.userPhoto)
    }
    
    func setPhone(phone:String){
        keychain.set(phone, forKey: ProfileKeys.userPhone)
    }
    func setIsClinicAccount(_ hasClinicAccount: Bool) {
        keychain.set(hasClinicAccount, forKey: ProfileKeys.hasClinicAccount)
    }
    
    // MARK: - Get Personal Info
    func getEmail() -> String?{
        return keychain.get(ProfileKeys.email)
    }
    
    func getUsername() -> String?{
        return keychain.get(ProfileKeys.username)
    }
    
    func getFirstName() -> String?{
        return keychain.get(ProfileKeys.firstName)
    }
    func getSecondName() -> String?{
        return keychain.get(ProfileKeys.secondName)
    }
    func getMiddleName() -> String?{
        return keychain.get(ProfileKeys.middleName)
    }
    
    func getId() -> String?{
        return keychain.get(ProfileKeys.id)
    }
    
    func getrCeatedAt() -> String?{
        return keychain.get(ProfileKeys.createdAt)
    }
    
    func getUpdatedAt() -> String?{
        return keychain.get(ProfileKeys.updatedAt)
    }
    
    func getUserPhoto() -> Data?{
        return keychain.getData(ProfileKeys.userPhoto)
    }
    
    func getPhone() -> String? {
        return keychain.get(ProfileKeys.userPhone)
    }
    func getIsClinicAccount() -> Bool? {
        return keychain.getBool(ProfileKeys.hasClinicAccount)
    }
    
    
    // MARK: - Delete PersonalData
    func deleteEmail(){
        keychain.delete(ProfileKeys.email)
    }
    
    func deleteUsername(){
        keychain.delete(ProfileKeys.username)
    }
    
    func deleteId(){
        keychain.delete(ProfileKeys.id)
    }
    
    func deleteCreatedAt(){
        keychain.delete(ProfileKeys.createdAt)
    }
    
    func deleteUpdatedAt(){
        keychain.delete(ProfileKeys.updatedAt)
    }
    func deleteUserPhoto(){
        keychain.delete(ProfileKeys.userPhoto)
    }
    
    func deletePhone() {
        keychain.delete(ProfileKeys.userPhone)
    }
    
    func deleteIsClinicAccount() {
        keychain.delete(ProfileKeys.hasClinicAccount)
    }
    
    func deleteAll(){
        let keys = keychain.allKeys
        for deleteKey in keys {
            keychain.delete(deleteKey)
        }
    }
    
    
}
