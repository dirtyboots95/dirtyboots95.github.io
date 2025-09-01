#!/usr/bin/env node

// Google Analytics 4 API 테스트 스크립트
// 사용법: node test_ga4_api.js

const { BetaAnalyticsDataClient } = require('@google-analytics/data');
const path = require('path');

async function testGA4API() {
  try {
    console.log('🧪 Google Analytics 4 API 테스트 시작...');
    
    // 환경 변수 확인
    const credentialsPath = process.env.GOOGLE_APPLICATION_CREDENTIALS;
    const propertyId = process.env.GA4_PROPERTY_ID;
    
    if (!credentialsPath) {
      console.error('❌ GOOGLE_APPLICATION_CREDENTIALS 환경 변수가 설정되지 않았습니다.');
      console.log('💡 다음 명령어로 환경 변수를 설정하세요:');
      console.log('   source setup_env.sh');
      return;
    }
    
    if (!propertyId) {
      console.error('❌ GA4_PROPERTY_ID 환경 변수가 설정되지 않았습니다.');
      console.log('💡 다음 명령어로 환경 변수를 설정하세요:');
      console.log('   source setup_env.sh');
      return;
    }
    
    console.log(`✅ 자격 증명 파일: ${credentialsPath}`);
    console.log(`✅ GA4 Property ID: ${propertyId}`);
    
    // Google Analytics 클라이언트 초기화
    const analyticsDataClient = new BetaAnalyticsDataClient({
      keyFilename: credentialsPath
    });
    
    console.log('🔌 GA4 클라이언트 초기화 완료');
    
    // 테스트 쿼리 실행
    console.log('📊 방문자 통계 가져오는 중...');
    
    const [response] = await analyticsDataClient.runReport({
      property: `properties/${propertyId}`,
      dateRanges: [
        {
          startDate: '7daysAgo',
          endDate: 'today'
        }
      ],
      metrics: [
        {
          name: 'totalUsers'
        }
      ]
    });
    
    if (response.rows && response.rows.length > 0) {
      const totalUsers = response.rows[0].metricValues[0].value;
      console.log(`✅ 최근 7일 총 방문자: ${totalUsers}명`);
    } else {
      console.log('⚠️ 데이터가 없습니다. GA4 설정을 확인해주세요.');
    }
    
    console.log('🎉 API 테스트 완료!');
    
  } catch (error) {
    console.error('❌ API 테스트 실패:', error.message);
    
    if (error.message.includes('authentication')) {
      console.log('💡 인증 오류. 서비스 계정 키 파일을 확인해주세요.');
    } else if (error.message.includes('permission')) {
      console.log('💡 권한 오류. GA4 속성에 서비스 계정 권한을 부여해주세요.');
    } else if (error.message.includes('not found')) {
      console.log('💡 속성을 찾을 수 없습니다. Property ID를 확인해주세요.');
    }
  }
}

// 스크립트 실행
testGA4API();
