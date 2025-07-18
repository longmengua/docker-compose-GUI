from locust import HttpUser, task, between
import time

class CourseActivityUser(HttpUser):
    wait_time = between(0.5, 1)  # 每個請求間隔 0.5-1 秒

    def on_start(self):
        """模擬使用者登入，取得 Bearer Token (如果適用)"""
        self.token = ""  # 這裡填入有效的 Bearer Token


    # https://dev-api.top.one
    @task
    def get_member_info(self):
        """請求設定"""
        member_id = 924879
        headers = {
            "Authorization": f"Bearer {self.token}",
            "Accept": "*/*",
            "Content-Type": "application/json",
            "User-Agent": "Mozilla/5.0"
        }
        url = f"/gateway/v1/future/pairs/setting"
        self.client.get(url, headers=headers)

    # @task
    # def get_course_goal_and_time(self):
    #     """請求課程目標與時間 API"""
    #     url = "/api/v1/Schedule/GetCourseGoalAndTime?type=2&memberLevel=3"
    #     headers = {
    #         "Authorization": f"Bearer {self.token}",
    #         "Accept": "*/*",
    #         "Content-Type": "application/json",
    #         "User-Agent": "Mozilla/5.0"
    #     }
    #     self.client.get(url, headers=headers)

    # @task
    # def get_course_other_detail(self):
    #     """請求課程詳細資訊 API"""
    #     course_id = "E25009679"
    #     url = f"/api/v1/NewCourse/GetCourseOtherDetailWithMember/{course_id}"
    #     headers = {
    #         "Authorization": f"Bearer {self.token}",
    #         "Accept": "application/json, text/plain, */*",
    #         "Content-Type": "application/json",
    #         "User-Agent": "Mozilla/5.0"
    #     }
    #     self.client.get(url, headers=headers)

    # @task
    # def is_class_reminder_set(self):
    #     """檢查課程是否已設定提醒"""
    #     class_id = "E25009679"
    #     url = f"/api/v1/TutorClass/IsClassReminderSet?classId={class_id}"
    #     headers = {
    #         "Authorization": f"Bearer {self.token}",
    #         "Accept": "*/*",
    #         "Content-Type": "application/json",
    #         "User-Agent": "Mozilla/5.0"
    #     }
    #     self.client.get(url, headers=headers)

    # @task
    # def get_course_information(self):
    #     """請求課程基本資訊 API"""
    #     course_id = "E25009679"
    #     url = f"/api/v1/NewCourse/GetCourseInformation/{course_id}"
    #     headers = {
    #         "Authorization": f"Bearer {self.token}",
    #         "Accept": "application/json, text/plain, */*",
    #         "User-Agent": "Mozilla/5.0"
    #     }
    #     self.client.get(url, headers=headers)

    # @task
    # def get_class_swiper(self):
    #     """請求即興演講課程的 Swiper API"""
    #     sub_category = "impromptuspeaking"
    #     url = f"/api/v1/TutorClass/ClassSwiper?subCategory={sub_category}"
    #     headers = {
    #         "Authorization": f"Bearer {self.token}",
    #         "Accept": "*/*",
    #         "Content-Type": "application/json",
    #         "User-Agent": "Mozilla/5.0"
    #     }
    #     self.client.get(url, headers=headers)