// Netlify Functions용 Google Analytics Data API v1
// 방문자 통계를 가져오는 서버리스 함수

const { BetaAnalyticsDataClient } = require('@google-analytics/data');

exports.handler = async function(event, context) {
  // CORS 헤더 설정
  const headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
    'Content-Type': 'application/json'
  };

  // OPTIONS 요청 처리 (CORS preflight)
  if (event.httpMethod === 'OPTIONS') {
    return {
      statusCode: 200,
      headers,
      body: ''
    };
  }

  try {
    const { property_id } = event.queryStringParameters || {};
    
    if (!property_id) {
      return {
        statusCode: 400,
        headers,
        body: JSON.stringify({ 
          error: 'property_id is required',
          message: 'GA4 Property ID가 필요합니다.'
        })
      };
    }

    // Google Analytics 클라이언트 초기화
    const analyticsDataClient = new BetaAnalyticsDataClient({
      keyFilename: process.env.GOOGLE_APPLICATION_CREDENTIALS || 'google-credentials.json'
    });

    // 오늘 날짜 계산
    const today = new Date();
    const startDate = new Date(today.getFullYear(), today.getMonth(), today.getDate());
    const endDate = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 1);

    // 총 방문자 수 가져오기 (30일)
    const [totalVisitorsResponse] = await analyticsDataClient.runReport({
      property: `properties/${property_id}`,
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

    // 오늘 방문자 수 가져오기
    const [todayVisitorsResponse] = await analyticsDataClient.runReport({
      property: `properties/${property_id}`,
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

    // 총 페이지뷰 가져오기 (30일)
    const [totalPageviewsResponse] = await analyticsDataClient.runReport({
      property: `properties/${property_id}`,
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

    const data = {
      total_visitors: parseInt(totalVisitorsResponse.rows?.[0]?.metricValues?.[0]?.value || 0),
      today_visitors: parseInt(todayVisitorsResponse.rows?.[0]?.metricValues?.[0]?.value || 0),
      total_pageviews: parseInt(totalPageviewsResponse.rows?.[0]?.metricValues?.[0]?.value || 0),
      last_updated: new Date().toISOString(),
      source: 'GA4 Data API v1'
    };

    return {
      statusCode: 200,
      headers,
      body: JSON.stringify(data)
    };

  } catch (error) {
    console.error('Analytics API Error:', error);
    
    // 에러 응답에 더 자세한 정보 포함
    return {
      statusCode: 500,
      headers,
      body: JSON.stringify({ 
        error: 'Failed to fetch analytics data',
        message: '방문자 통계를 가져오는데 실패했습니다.',
        details: error.message,
        timestamp: new Date().toISOString()
      })
    };
  }
};
