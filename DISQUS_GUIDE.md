# Disqus Guestbook 설정 가이드

## 현재 설정 상태

### ✅ 완료된 설정:
- Guestbook 전용 레이아웃 생성
- Disqus 댓글 시스템 연동
- Guestbook 페이지별 고유 식별자 설정

## Disqus 관리자에서 Guestbook 댓글 관리하기

### 1. Disqus 관리자 접속
1. [Disqus 관리자](https://dirtyboots95.disqus.com/admin/)에 접속
2. 로그인 후 대시보드 확인

### 2. Guestbook 댓글 필터링

#### 방법 1: 카테고리별 필터링
1. **Moderate** → **Comments** 메뉴로 이동
2. **Filter by** 드롭다운에서 **Category** 선택
3. **guestbook** 카테고리 선택
4. Guestbook에만 남겨진 댓글들만 표시됨

#### 방법 2: URL별 필터링
1. **Moderate** → **Comments** 메뉴로 이동
2. **Filter by** 드롭다운에서 **URL** 선택
3. **guestbook** 또는 **guestbook.html** 검색
4. Guestbook 페이지의 댓글들만 표시됨

#### 방법 3: 고급 검색
1. **Moderate** → **Comments** 메뉴로 이동
2. 검색창에 다음 중 하나 입력:
   - `category:guestbook`
   - `url:guestbook`
   - `identifier:guestbook`

### 3. 댓글 관리 기능

#### 승인/거부
- ✅ **Approve**: 댓글을 공개로 승인
- ❌ **Spam**: 스팸으로 표시하고 숨김
- 🗑️ **Delete**: 댓글 완전 삭제

#### 일괄 작업
- 여러 댓글 선택 후 일괄 승인/거부 가능
- **Bulk Actions** 드롭다운 사용

### 4. 알림 설정

#### 이메일 알림
1. **Settings** → **Notifications** 메뉴로 이동
2. **Email notifications** 설정
3. 새 댓글 알림 받기 설정

#### 웹훅 설정 (선택사항)
1. **Settings** → **Webhooks** 메뉴로 이동
2. 새 댓글 발생 시 특정 URL로 알림 받기 설정

## Disqus API를 통한 댓글 조회 (고급)

### 1. API 키 발급
1. [Disqus API](https://disqus.com/api/applications/)에서 애플리케이션 생성
2. API 키 발급 받기

### 2. Guestbook 댓글만 조회하는 API 호출
```javascript
// Guestbook 댓글만 조회하는 예시
const disqusApiUrl = 'https://disqus.com/api/3.0/threads/listPosts.json';
const params = {
  api_key: 'YOUR_API_KEY',
  forum: 'dirtyboots95',
  thread: 'link:https://dirtyboots95.github.io/guestbook.html'
};

fetch(`${disqusApiUrl}?${new URLSearchParams(params)}`)
  .then(response => response.json())
  .then(data => {
    console.log('Guestbook 댓글들:', data.response);
  });
```

### 3. 댓글 통계 확인
```javascript
// Guestbook 댓글 통계
const statsUrl = 'https://disqus.com/api/3.0/forums/listThreads.json';
const statsParams = {
  api_key: 'YOUR_API_KEY',
  forum: 'dirtyboots95',
  thread: 'link:https://dirtyboots95.github.io/guestbook.html'
};
```

## 문제 해결

### 댓글이 표시되지 않는 경우
1. **Disqus 설정 확인**
   - `_config.yml`의 `disqus_shortname` 확인
   - Guestbook 페이지의 `comments: true` 설정 확인

2. **페이지 식별자 확인**
   - 브라우저 개발자 도구에서 Disqus 스크립트 로드 확인
   - 페이지 URL과 식별자가 올바른지 확인

3. **Disqus 관리자에서 확인**
   - 댓글이 스팸으로 분류되지 않았는지 확인
   - 댓글이 승인 대기 중인지 확인

### 성능 최적화
1. **지연 로딩 설정**
   - Disqus 스크립트를 페이지 하단에 배치
   - 사용자가 댓글 영역까지 스크롤할 때 로드

2. **캐싱 설정**
   - Jekyll 빌드 시 Disqus 댓글 캐싱
   - 정적 사이트에서 댓글 로딩 속도 개선

## 추가 기능

### 댓글 알림 봇 (선택사항)
- 새 댓글 발생 시 슬랙/디스코드로 알림
- 댓글 내용 분석 및 스팸 자동 필터링

### 댓글 백업
- 정기적으로 댓글 데이터 백업
- Disqus API를 통한 댓글 내보내기

---

**참고**: Disqus 무료 플랜에서는 기본적인 댓글 관리 기능을 제공합니다. 더 고급 기능이 필요하면 Disqus Pro 플랜을 고려해보세요.
