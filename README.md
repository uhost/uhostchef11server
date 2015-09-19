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
    <td><tt>['uhostchef11server']['notification_email']</tt></td>
    <td>String</td>
    <td>chef server notification_email value</td>
    <td><tt>support@getuhost.org</tt></td>
  </tr>
  <tr>
    <td><tt>['uhostchef11server']['topology']</tt></td>
    <td>String</td>
    <td>chef server topology value</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['uhostchef11server']['erchef']['s3_url_ttl']</tt></td>
    <td>Integer</td>
    <td>chef server erchef s3_url_ttl value</td>
    <td><tt>3600</tt></td>
  </tr>
  <tr>
    <td><tt>['uhostchef11server']['bootstrap']</tt></td>
    <td>Boolean</td>
    <td>chef server bootstrap value</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['uhostchef11server']['nginx']['certificate']</tt></td>
    <td>String</td>
    <td>databag for the nginx ssl certificate</td>
    <td><tt>uhost.getuhost.org</tt></td>
  </tr>
</table>

## Usage

### uhostchef11server::default

Include `uhostchef11server` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[uhostserver::default]"
  ]
}
```

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

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request


## License and Authors

Author:: YOUR_NAME (<YOUR_EMAIL>)
