#!/usr/bin/env node

// Google Analytics 4 API 테스트 스크립트
// 로컬에서 GA4 Data API가 제대로 작동하는지 확인

const { BetaAnalyticsDataClient } = require('@google-analytics/data');

async function testGA4API() {
  try {
    console.log('🔍 Google Analytics 4 API 테스트 시작...\n');
    
    // Google Analytics 클라이언트 초기화
    const analyticsDataClient = new BetaAnalyticsDataClient({
      keyFilename: './google-credentials.json'
    });
    
    const propertyId = '503083435';
    console.log(`📊 GA4 Property ID: ${propertyId}`);
    console.log(`🔑 인증 파일: google-credentials.json\n`);
    
    // 오늘 날짜 계산
    const today = new Date();
    const startDate = new Date(today.getFullYear(), today.getMonth(), today.getDate());
    const endDate = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 1);
    
    console.log('📅 데이터 범위:');
    console.log(`   - 총 방문자: 30일 전 ~ 오늘`);
    console.log(`   - 오늘 방문자: ${startDate.toISOString().split('T')[0]} ~ ${endDate.toISOString().split('T')[0]}`);
    console.log(`   - 총 페이지뷰: 30일 전 ~ 오늘\n`);
    
    // 총 방문자 수 가져오기 (30일)
    console.log('🔄 총 방문자 수 조회 중...');
    const [totalVisitorsResponse] = await analyticsDataClient.runReport({
      property: `properties/${propertyId}`,
      dateRanges: [
        {
          startDate: '30daysAgo',
          endDate: 'today'
        }
      ],
      metrics: [
        {
          name: 'totalUsers'
        }
      ]
    });
    
    const totalVisitors = parseInt(totalVisitorsResponse.rows?.[0]?.metricValues?.[0]?.value || 0);
    console.log(`✅ 총 방문자: ${totalVisitors.toLocaleString()}명\n`);
    
    // 오늘 방문자 수 가져오기
    console.log('🔄 오늘 방문자 수 조회 중...');
    const [todayVisitorsResponse] = await analyticsDataClient.runReport({
      property: `properties/${propertyId}`,
      dateRanges: [
        {
          startDate: startDate.toISOString().split('T')[0],
          endDate: endDate.toISOString().split('T')[0]
        }
      ],
      metrics: [
        {
          name: 'totalUsers'
        }
      ]
    });
    
    const todayVisitors = parseInt(todayVisitorsResponse.rows?.[0]?.metricValues?.[0]?.value || 0);
    console.log(`✅ 오늘 방문자: ${todayVisitors.toLocaleString()}명\n`);
    
    // 총 페이지뷰 가져오기 (30일)
    console.log('🔄 총 페이지뷰 조회 중...');
    const [totalPageviewsResponse] = await analyticsDataClient.runReport({
      property: `properties/${propertyId}`,
      dateRanges: [
        {
          startDate: '30daysAgo',
          endDate: 'today'
        }
      ],
      metrics: [
        {
          name: 'screenPageViews'
        }
      ]
    });
    
    const totalPageviews = parseInt(totalPageviewsResponse.rows?.[0]?.metricValues?.[0]?.value || 0);
    console.log(`✅ 총 페이지뷰: ${totalPageviews.toLocaleString()}회\n`);
    
    // 결과 요약
    console.log('📊 📊 📊 📊 📊 📊 📊 📊 📊 📊 📊 📊 📊 📊 📊 📊 📊 📊 📊 📊');
    console.log('🎉 API 테스트 성공!');
    console.log('📊 📊 📊 📊 📊 📊 📊 📊 📊 📊 📊 📊 📊 📊 📊 📊 📊 📊 📊 📊\n');
    
    console.log('📈 방문자 통계 요약:');
    console.log(`   📊 총 방문자 (30일): ${totalVisitors.toLocaleString()}명`);
    console.log(`   👥 오늘 방문자: ${todayVisitors.toLocaleString()}명`);
    console.log(`   📈 총 페이지뷰 (30일): ${totalPageviews.toLocaleString()}회\n`);
    
    console.log('💡 이제 Jekyll 사이트에서 방문자 카운터가 실제 데이터를 표시할 것입니다!');
    
  } catch (error) {
    console.error('❌ API 테스트 실패:', error.message);
    console.error('\n🔧 문제 해결 방법:');
    console.error('   1. google-credentials.json 파일이 프로젝트 루트에 있는지 확인');
    console.error('   2. Google Analytics Data API v1이 활성화되어 있는지 확인');
    console.error('   3. 서비스 계정에 GA4 데이터 읽기 권한이 있는지 확인');
    console.error('   4. Property ID가 올바른지 확인');
    
    if (error.message.includes('ENOENT')) {
      console.error('\n📁 파일을 찾을 수 없습니다: google-credentials.json');
      console.error('   .secrets/ga4-service-account.json을 google-credentials.json으로 복사하세요.');
    }
  }
}

// 스크립트 실행
if (require.main === module) {
  testGA4API();
}

module.exports = { testGA4API };
