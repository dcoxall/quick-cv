# Quick CV
Quick CV is aimed at removing the hassle of keeping your Curriculum Vitae or Resume up-to-date. These days I use LinkedIn and if anything changes that gets updated before my actual CV.

Quick CV will eventually be able to generate a professional looking CV using only the data you have already stored on LinkedIn.

### Dependencies
- **LinkedIn App**. Quick CV uses the LinkedIn api to get the data in which to populate the CV/Resume
- **Memcache** to handle the applications cache
- **Ruby 1.9.3** the main application is developed to run on ruby1.9.3 but other versions may well work

### Development
Quick CV uses bundler to manage gem dependencies. To get started make sure you have ruby1.9.3 *(or any other supported ruby version)*, bundler gem installed and memcache running *(by default it expects localhost to have a memcache server running on the default port).*

Create a [LinkedIn App](https://www.linkedin.com/secure/developer?newapp=) and store the app key and app secret in an environment variable (`LINKEDIN_APP_KEY` and `LINKEDIN_APP_SECRET` respectively)

Now use the following to start a local server.

    bundle install
    LINKEDIN_APP_KEY=xxx LINKEDIN_APP_SECRET=xxx bundle exec shotgun

### Roadmap
- PDF generation using `prawn`
- Tests, specs and VCR recordings
- Front-end design/UI
- Customisable sections *(displaying languages instead of skills for example)*
- Customisable order *(order the sections using drag and drop)*
- Shareable URIs *(share a custom URI that will render your up-to-date CV)*
- ???
- Suggestions?

### Contributing
Contributions are more than welcome! Please just fork the repository and make a pull request when complete.

As you can see there are currently no tests/specs and this is something I would like to change so any pull requests that implement tests will be highly appreciated. The test framework by the way will likely be `rspec` although feel free to suggest something else.

VCR recordings for later testing would be hugely helpful. Thos with knowledge on how to do that please contribute. Don't forget to remove any personal identifying information from the recordings. As always testing against real user data would be much more beneficial to identifying issues.

Feel free to also create a CONTRIBUTIONS.md and add yourself to that.


### License
```
Quick CV, automating cv and resume updates
Copyright (C) 2013  Darren A Coxall

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
```
