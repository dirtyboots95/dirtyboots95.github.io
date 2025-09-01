// Google Analytics Data API v1을 사용하여 방문자 통계 가져오기
// 이 파일은 Netlify Functions, Vercel Functions 등에서 사용할 수 있습니다

const { BetaAnalyticsDataClient } = require('@google-analytics/data');

exports.handler = async function(event, context) {
  // CORS 헤더 설정
  const headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Content-Type': 'application/json'
  };

  try {
    const { property_id } = event.queryStringParameters || {};
    
    if (!property_id) {
      return {
        statusCode: 400,
        headers,
        body: JSON.stringify({ error: 'property_id is required' })
      };
    }

    // Google Analytics 클라이언트 초기화
    const analyticsDataClient = new BetaAnalyticsDataClient({
      keyFilename: process.env.GOOGLE_APPLICATION_CREDENTIALS
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
      total_visitors: totalVisitorsResponse.rows?.[0]?.metricValues?.[0]?.value || 0,
      today_visitors: todayVisitorsResponse.rows?.[0]?.metricValues?.[0]?.value || 0,
      total_pageviews: totalPageviewsResponse.rows?.[0]?.metricValues?.[0]?.value || 0
    };

    return {
      statusCode: 200,
      headers,
      body: JSON.stringify(data)
    };

  } catch (error) {
    console.error('Analytics API Error:', error);
    
    return {
      statusCode: 500,
      headers,
      body: JSON.stringify({ 
        error: 'Failed to fetch analytics data',
        details: error.message 
      })
    };
  }
};
