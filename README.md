Elastic Search AWS AMI with Packer
=============

## Requirements

* Install [Packer](https://www.packer.io/) and add it to your PATH.
* [Authenticate through the firewall](https://10.10.20.1:4100/wgcgi.cgi).
* [Add temporary AWS tokens to your terminal session](https://status.pageuppeople.com/AWSToken).

## Create packer_vars.json file

Under project directory, create a file named `packer_vars.json` and add the following content, replacing it with your own access/secret/token:

```
{
  "aws_access_key": "<enter access key here>",
  "aws_secret_key": "<enter secret key here>",
  "aws_security_token": "<enter token here>"
}
```

## Do Changes

Whatever that needs to be updated, do the changes within the specific DC within the /vars/dcX.json file.  If it's a 'global' change (ie. updating elasticsearch version), do it within the elastic.json file.  

Do not add new features unless it will greatly reduce instance startup time, if not, it should be added as a user data script within the [terraform-elasticsearch project](PageUpPeopleOrg/terraform-elasticsearch).

## Build

This will create a new AMI with everything ready to go within a singular DC at a time.  There's a good chance that the changes need to be applied for all DCs, so don't forget to run it for each one.

To get started, run the command like this:

```
packer build -var-file=path/to/packer_vars.json -var-file=vars/dcX.json elastic.json
```

For instance, if you wanted to run it DC2:

```
packer build -var-file=packer_vars.json -var-file=vars/dc2.json elastic.json
```

Then just wait for the instance to spin up, do its thing and create the new AMI.  If stuck at the SSH connection, make sure you're still authed on the firewall.

## Next Steps

After packer gives you the new AMI ID per DC, you'll want to [update the AMI ID within the terraform config variables](PageUpPeopleOrg/orca-stack-config-variables) then run terraform to update the launch configuration.

## Available Variables

* aws_source_ami (defaults to none, please update)
* aws_access_key (defaults to none, please update)
* aws_secret_key (defaults to none, please update)
* aws_security_token (defaults to none)
* aws_region (defaults to `ap-southeast-2`)
* aws_instance_type (defaults to `t2.medium`)
* ami_name_prefix (defaults to `elasticsearch`)
* elastic_version (defaults to `2.4.1`)
* aws_build_regions (defaults to none)
* aws_instance_type (defaults to `t2.medium`)
* aws_vpc_id (defaults to none)
* aws_subnet_id (defaults to none)
* consul_version (defaults to `0.6.3`)
* consul_template_version (defaults to `0.12.1`)

