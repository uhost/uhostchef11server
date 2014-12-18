# uhostserver-cookbook

TODO: Enter the cookbook description here.

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['uhostserver']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### uhostserver::default

Include `uhostserver` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[uhostserver::default]"
  ]
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## Testing

Install Chef DK
https://downloads.getchef.com/chef-dk

Make sure that chef-dk is in your path

Install bundler
sudo gem install bundler

Install packages in the Gemfile
bundle

Lint
foodcritic .

Unit Test - using chefspec
rspec --color

Integration Test - using test-kitchen
kitchen converge
kitchen setup
kitchen verify

## Development

kitchen converge 


## License and Authors

Author:: YOUR_NAME (<YOUR_EMAIL>)
