require_relative '../spec_helper'
require_relative '../../../lib/ruby_aem/handlers/json'

describe 'JSON Handler' do
  before do
  end

  after do
  end

  describe 'test json_authorizable_id' do

    it 'should return success result when authorizable ID is found' do
      data = '{"success":true,"results":1,"total":1,"more":false,"offset":0,"hits":[{"path":"/home/groups/s/cnf6J9EF5WtGm9X6CZT4","excerpt":"","name":"cnf6J9EF5WtGm9X6CZT4","title":"cnf6J9EF5WtGm9X6CZT4","lastModified":"2016-09-12 21:13:07","created":"2016-09-12 21:13:07"}]}'
      status_code = nil
      headers = nil
      response_spec = { 'status' => 'success', 'message' => 'Found user %{name} authorizable ID %{authorizable_id}' }
      info = { :name => 'someuser' }

      response = RubyAem::Response.new(status_code, data, headers)
      result = RubyAem::Handlers.json_authorizable_id(response, response_spec, info)
      expect(result.is_success?).to be(true)
      expect(result.message).to eq('Found user someuser authorizable ID cnf6J9EF5WtGm9X6CZT4')
      expect(result.data).to eq('cnf6J9EF5WtGm9X6CZT4')
    end

    it 'should return failure result when authorizable ID is not found' do
      data = '{"success":false,"results":0,"total":0,"more":false,"offset":0,"hits":[]}'
      status_code = nil
      headers = nil
      response_spec = { 'status' => 'success', 'message' => 'Found user %{name} authorizable ID %{authorizable_id}' }
      info = { :name => 'someuser' }

      response = RubyAem::Response.new(status_code, data, headers)
      result = RubyAem::Handlers.json_authorizable_id(response, response_spec, info)
      expect(result.is_success?).to be(true)
      expect(result.message).to eq('User/Group someuser authorizable ID not found')
      expect(result.data).to eq(nil)
    end

  end

  describe 'test json_package_service' do

    it 'should return result with status and message from data payload' do
      data = '{ "success": true, "msg": "Package built" }'
      status_code = nil
      headers = nil
      response_spec = nil
      info = {}

      response = RubyAem::Response.new(status_code, data, headers)
      result = RubyAem::Handlers.json_package_service(response, response_spec, info)
      expect(result.is_success?).to be(true)
      expect(result.message).to eq('Package built')
    end

  end

  describe 'test json_package_filter' do

    it 'should return success result with filter data payload' do
      data =
        '{' \
        '  "jcr:primaryType": "nt:unstructured",' \
        '  "f0": {' \
        '    "jcr:primaryType": "nt:unstructured",' \
        '    "mode": "replace",' \
        '    "root": "/apps/geometrixx",' \
        '    "rules": []' \
        '  },' \
        '  "f1": {' \
        '    "jcr:primaryType": "nt:unstructured",' \
        '    "mode": "replace",' \
        '    "root": "/apps/geometrixx-common",' \
        '    "rules": []' \
        '  }' \
        '}'
      status_code = nil
      headers = nil
      response_spec = { 'status' => 'success', 'message' => 'Filter retrieved successfully' }
      info = {}

      response = RubyAem::Response.new(status_code, data, headers)
      result = RubyAem::Handlers.json_package_filter(response, response_spec, info)
      expect(result.is_success?).to be(true)
      expect(result.message).to eq('Filter retrieved successfully')
      expect(result.data.length).to eq(2)
      expect(result.data[0]).to eq('/apps/geometrixx')
      expect(result.data[1]).to eq('/apps/geometrixx-common')
    end

  end

end
