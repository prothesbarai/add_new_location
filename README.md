# 🗺️ Add New Location -- Flutter App

একটি প্রফেশনাল এবং সহজে ব্যবহারযোগ্য **Flutter Location Management
App**!\
এই অ্যাপটি ব্যবহার করে আপনি সহজেই লোকেশন যোগ, আপডেট এবং ম্যানেজ করতে
পারবেন।

------------------------------------------------------------------------

## 🚀 মূল বৈশিষ্ট্য (Features)

### 📍 ১. লোকেশন অ্যাড করা

সহজেই নতুন লোকেশন Latitude ও Longitude দিয়ে সেভ করা যায়।

### 🗂️ ২. লোকেশন লিস্ট

সকল সংরক্ষিত লোকেশন সুন্দর UI সহ লিস্ট আকারে দেখা যাবে।

### ✏️ ৩. আপডেট / এডিট

কোনো লোকেশন ভুল হলে অ্যাপ থেকে সরাসরি এডিট করার সুবিধা আছে।

### 🗑️ ৪. ডিলিট অপশন

এক ক্লিকে যেকোনো লোকেশন মুছে ফেলতে পারবেন।

### 📡 ৫. ব্যাকএন্ড সাপোর্ট

লোকেশন ডেটা Local Storage (SQLite/Hive) বা API--- উভয় দিয়েই কাজ করবে।

### 🎯 ৬. সহজ UI

সিম্পল, ক্লিন এবং প্রফেশনাল UI ডিজাইন।

------------------------------------------------------------------------

## 🖼️ Screenshots

চারটি স্ক্রিনশট এক লাইনে প্রদর্শন:

<table>
  <tr>
    <td><img src="assets/img.png" width="90%"/></td>
    <td><img src="assets/img_1.png" width="90%"/></td>
    <td><img src="assets/img_2.png" width="90%"/></td>
    <td><img src="assets/img_3.png" width="90%"/></td>
  </tr>
</table>

------------------------------------------------------------------------

## 📦 Installation

``` bash
git clone https://github.com/prothesbarai/add_new_location
cd add_new_location
flutter pub get
flutter run
```

------------------------------------------------------------------------

## 🗺️ ব্যবহার

-   অ্যাপ চালু করলে আপনি 'Add Location' বাটন দেখতে পাবেন\
-   ক্লিক করে Location ফর্ম ওপেন করুন\
-   Latitude / Longitude দিন\
-   Save করুন\
-   লিস্ট পেজে সব লোকেশন দেখুন

------------------------------------------------------------------------

------------------------------------------------------------------------
------------------------------------------------------------------------
## কিভাবে Google Maps API key বানাবে এবং Flutter project এ ব্যবহার করবে:
### 1️⃣ Google Cloud Console এ যান
- ব্রাউজারে গিয়ে যাও: https://console.cloud.google.com/
- Google account দিয়ে login করো।
  
### 2️⃣ Project তৈরি করুন
- If you want Create New Project (If no exist related projects)
- Project name দাও (যেমন: My Project 98110)
- Create চাপো

### 3️⃣ Maps API Enable করা
- Quick access (below) → APIs & Services → Library
- Search করো Maps SDK for Android → Enable
- Search করো Maps SDK for iOS → Enable
- Search করো Places API → Enable (search address এর জন্য)
- Search করো Geocoding API (For Convert addresses into geographic coordinates)
- Search করো Directions API (For Access driving, cycling, walking and public transportation routing with the Directions API using an HTTP request)
- Search করো Geolocation API (For জিওলোকেশন API ব্যবহার করে মোবাইল ক্লায়েন্ট যে সেল টাওয়ার এবং ওয়াইফাই অ্যাক্সেস পয়েন্টগুলি সনাক্ত করতে পারে তার মতো তথ্যের উপর ভিত্তি করে একটি অবস্থান এবং নির্ভুলতা ব্যাসার্ধ খুঁজুন। এটি মূলত এমন ক্ষেত্রে ব্যবহৃত হয় যেখানে জিপিএস সম্ভব বা উপযুক্ত নয়।)
- Search করো Maps JavaScript API (For Web)
- All Enable


### 4️⃣ API Key তৈরি কর
- APIs & Services → Credentials → Create Credentials → API key
- 1️⃣ Name তুমি API key 1 দিলে চলবে। নাম শুধু internal reference এর জন্য।
- 2️⃣ Authenticate API calls : সাধারণ Flutter map / search use এর জন্য unchecked রাখো। Service account দরকার নেই।
- 3️⃣ Application restrictions : তুমি এখন None রেখেছো → test এর জন্য ঠিক আছে। পরে security increase করতে চাইলে Android/iOS restrict করতে হবে।
- 4️⃣ API restrictions : তুমি Don't restrict key রেখেছো → সব API call যাবে। Later তুমি শুধু Maps SDK, Places API restrict করতে পারো।
- 5️⃣ পরবর্তী step : Create চাপো → copy করা key নিয়ে Flutter code এ বসাও:


### 5️⃣ Key কে Restrict করা (optional but recommended)
- Restrict Key → HTTP referrers (web sites) বা Android apps / iOS apps
- Android: package name + SHA1 fingerprint
- iOS: Bundle Identifier
- Note: Restrict না করলে key সব জায়গা থেকে কাজ করবে, কিন্তু security কমে।


## © 2025 -- prothesbarai
Flutter দিয়ে তৈরি একটি সুন্দর Location Management সিস্টেম।
